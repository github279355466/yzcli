"""Skill management commands"""
import json
import os
import re
import shutil
import zipfile
from pathlib import Path
import click


SKILL_DIR_NAME = "yzcli-agent-skill"
SKILL_FILE = "SKILL.md"
VERSION_PATTERN = re.compile(r"^version:\s*(.+)$", re.MULTILINE)
VERSION_BODY_PATTERN = re.compile(r"\*\*版本\*\*:\s*[\d.]+")

# All platform deploy paths (auto-deployed by `yzcli skill pack`)
DEPLOY_PATHS = [
    "~/.claude/skills/yzcli-erp",
    "~/.codex/skills/yzcli-erp",
]


def _find_skill_dir() -> Path:
    """Find the skill package directory relative to project root"""
    project_root = Path(__file__).parent.parent.parent.parent
    skill_dir = project_root / SKILL_DIR_NAME
    if not skill_dir.exists():
        raise click.ClickException(f"Skill directory not found: {skill_dir}")
    return skill_dir


def _parse_frontmatter_version(content: str) -> str:
    """Extract version from SKILL.md frontmatter"""
    match = VERSION_PATTERN.search(content)
    if match:
        return match.group(1).strip()
    raise click.ClickException("No 'version' field found in SKILL.md frontmatter")


def _bump_patch(version: str) -> str:
    """Bump patch version: 3.1.0 -> 3.1.1"""
    parts = version.split(".")
    if len(parts) != 3:
        raise click.ClickException(f"Invalid version format: {version} (expected X.Y.Z)")
    major, minor, patch = int(parts[0]), int(parts[1]), int(parts[2])
    return f"{major}.{minor}.{patch + 1}"


def _update_version_in_content(content: str, old_version: str, new_version: str) -> str:
    """Update version in both frontmatter and body"""
    content = VERSION_PATTERN.sub(f"version: {new_version}", content)
    content = VERSION_BODY_PATTERN.sub(f"**版本**: {new_version}", content)
    return content


def _deploy_skill(skill_file: Path) -> list:
    """Deploy SKILL.md to all platform paths. Returns list of deployed paths."""
    deployed = []
    for raw_path in DEPLOY_PATHS:
        target_dir = Path(os.path.expanduser(raw_path))
        try:
            target_dir.mkdir(parents=True, exist_ok=True)
            shutil.copy2(skill_file, target_dir / SKILL_FILE)
            # Also copy references/ if it exists in source
            src_refs = skill_file.parent / "references"
            if src_refs.is_dir():
                dst_refs = target_dir / "references"
                if dst_refs.exists():
                    shutil.rmtree(dst_refs)
                shutil.copytree(src_refs, dst_refs)
            deployed.append(str(target_dir / SKILL_FILE))
        except OSError as e:
            click.echo(f"  [!] Failed to deploy to {target_dir}: {e}", err=True)
    return deployed


@click.group(name="skill")
def skill_cmd():
    """Skill 包管理"""
    pass


@skill_cmd.command(name="pack")
@click.option("--bump/--no-bump", default=True, help="Auto-increment patch version (default: yes)")
@click.option("--version", "set_version", default=None, help="Set specific version (e.g. 3.2.0)")
@click.option("--output-dir", default=None, help="Output directory for zip (default: project root)")
def pack_cmd(bump: bool, set_version: str, output_dir: str):
    """Pack skill into versioned zip and deploy to all platforms"""
    skill_dir = _find_skill_dir()
    skill_file = skill_dir / SKILL_FILE
    if not skill_file.exists():
        raise click.ClickException(f"SKILL.md not found: {skill_file}")

    content = skill_file.read_text(encoding="utf-8")
    current_version = _parse_frontmatter_version(content)

    if set_version:
        new_version = set_version
    elif bump:
        new_version = _bump_patch(current_version)
    else:
        new_version = current_version

    # Update version in SKILL.md
    if new_version != current_version:
        content = _update_version_in_content(content, current_version, new_version)
        skill_file.write_text(content, encoding="utf-8")
        click.echo(f"Version bumped: {current_version} -> {new_version}")
    else:
        click.echo(f"Version: {current_version} (unchanged)")

    # Build zip
    out_dir = Path(output_dir) if output_dir else skill_dir.parent
    zip_name = f"yzcli-agent-skill-v{new_version}.zip"
    zip_path = out_dir / zip_name

    for old_zip in out_dir.glob("yzcli-agent-skill-v*.zip"):
        old_zip.unlink()
        click.echo(f"Removed old zip: {old_zip.name}")

    exclude = {".omc", ".git", "node_modules", "__pycache__"}
    with zipfile.ZipFile(zip_path, "w", zipfile.ZIP_DEFLATED) as zf:
        for file in sorted(skill_dir.rglob("*")):
            if file.is_dir():
                continue
            rel = file.relative_to(skill_dir)
            if any(part in exclude for part in rel.parts):
                continue
            zf.write(file, rel)

    click.echo(f"Created: {zip_path.name} ({zip_path.stat().st_size:,} bytes)")

    # Deploy to all platforms
    click.echo("Deploying to platforms:")
    deployed = _deploy_skill(skill_file)
    for path in deployed:
        click.echo(f"  {path}")
    if not deployed:
        click.echo("  (no platforms deployed)")


@skill_cmd.command(name="version")
@click.option("--json-output", "as_json", is_flag=True, help="Output as JSON")
def version_cmd(as_json: bool):
    """Show skill source version"""
    skill_dir = _find_skill_dir()
    skill_file = skill_dir / SKILL_FILE

    version = None
    if skill_file.exists():
        content = skill_file.read_text(encoding="utf-8")
        version = _parse_frontmatter_version(content)

    if as_json:
        click.echo(json.dumps({"version": version or "not found"}, ensure_ascii=False))
    else:
        click.echo(f"Skill version: {version or 'not found'}")
