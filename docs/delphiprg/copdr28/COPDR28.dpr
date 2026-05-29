library COPDR28;

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
  RadicalD in 'M:\Class\RadicalD.pas' {dmRadical: TDataModule},
  COPDR28f in 'COPDR28f.pas' {frmCOPDR28},
  COPDR28d in 'COPDR28d.pas' {dmCOPDR28: TDataModule};

{$R *.res}

function StartPlug(Parent: Integer; Value: ShortString): Integer; export; stdcall;
begin
  Result := LibPlugin.DsPlugIn(TfrmCOPDR28, Parent, Value);
end;

exports
  StartPlug;
begin
end.

