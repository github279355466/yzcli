library INVkr18;

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters. }
uses
  SysUtils,
  Classes,
  LibPlugin,
  Radical in 'M:\Class\Radical.pas' {frmRadical},
  RPBaseOptF in 'M:\Class\RPBaseOptF.pas' {RPBaseOpt},
  RPBaseFmtF in 'M:\Class\RPBaseFmtF.pas' {RPBaseFmt},
  RPDetailFmtF in 'M:\Class\RPDetailFmtF.pas' {RPDetailFmt},
  RPBaseGridF in 'M:\Class\RPBaseGridF.pas' {RPBaseGrid},
  INVkr18o in 'INVkr18o.pas' {optINVkr18},
  INVkr18r in 'INVkr18r.pas' {fmtINVkr18},
  INVkr18g in 'INVkr18g.pas' {grdINVkr18};

{$R *.res}

function StartPlug( Parent: Integer; Value:ShortString ) : Integer ; export; stdcall;
begin
  Result := LibPlugin.DsPlugIn( ToptINVkr18 , Parent , Value ) ;
end;

exports
  StartPlug;

begin
end.
