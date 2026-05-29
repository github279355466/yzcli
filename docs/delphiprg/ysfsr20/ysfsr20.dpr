library ysfsr20;

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
  RPBaseOptF in 'M:\class\RPBaseOptF.pas' {RPBaseOpt},
  RPBaseFmtF in 'M:\class\RPBaseFmtF.pas' {RPBaseFmt},
  RPDetailFmtF in 'M:\class\RPDetailFmtF.pas' {RPDetailFmt},
  RPBaseGridF in 'M:\Class\RPBaseGridF.pas' {RPBaseGrid},
  ysfsr20o in 'ysfsr20o.pas' {Optysfsr20},
  ysfsr20r in 'ysfsr20r.pas' {Fmtysfsr20},
  ysfsr20g in 'ysfsr20g.pas' {grdysfsr20};

{$R *.res}

function StartPlug( Parent: Integer; Value:ShortString ) : Integer ; export; stdcall;
begin
  Result := LibPlugin.DsPlugIn( Toptysfsr20 , Parent , Value ) ;
end;

exports
  StartPlug;

begin
end.
