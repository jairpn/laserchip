unit uControllerFuncoes;

interface

uses
    Winapi.Windows, System.SysUtils, System.Math, System.Classes, Vcl.Forms, Vcl.StdCtrls, Vcl.Mask,
    System.Variants, System.TypInfo, System.Rtti, Vcl.Dialogs;

type
    TControllerFuncoes = class
        public
            class function IsValidCPF(pCPF: string): Boolean;
            procedure fechaForms;
            procedure limpaEdits(Form: Tform);
    end;

implementation


{ tControllerFuncoes }

class function TControllerFuncoes.IsValidCPF(pCPF: string): Boolean;
var
      v: array [0 .. 1] of Word;
    cpf: array [0 .. 10] of Byte;
    I: Byte;
begin
    Result := False;

    { Verificando se tem 11 caracteres }
    if Length(pCPF) <> 11 then
        begin
            Exit;
        end;

    { Conferindo se todos dígitos são iguais }
    if pCPF = StringOfChar('0', 11) then
        Exit;

    if pCPF = StringOfChar('1', 11) then
        Exit;

    if pCPF = StringOfChar('2', 11) then
        Exit;

    if pCPF = StringOfChar('3', 11) then
        Exit;

    if pCPF = StringOfChar('4', 11) then
        Exit;

    if pCPF = StringOfChar('5', 11) then
        Exit;

    if pCPF = StringOfChar('6', 11) then
        Exit;

    if pCPF = StringOfChar('7', 11) then
        Exit;

    if pCPF = StringOfChar('8', 11) then
        Exit;

    if pCPF = StringOfChar('9', 11) then
        Exit;

    try
        for I := 1 to 11 do
            cpf[I - 1] := StrToInt(pCPF[I]);
        // Nota: Calcula o primeiro dígito de verificação.
        v[0] := 10 * cpf[0] + 9 * cpf[1] + 8 * cpf[2];
        v[0] := v[0] + 7 * cpf[3] + 6 * cpf[4] + 5 * cpf[5];
        v[0] := v[0] + 4 * cpf[6] + 3 * cpf[7] + 2 * cpf[8];
        v[0] := 11 - v[0] mod 11;
        v[0] := IfThen(v[0] >= 10, 0, v[0]);
        // Nota: Calcula o segundo dígito de verificação.
        v[1] := 11 * cpf[0] + 10 * cpf[1] + 9 * cpf[2];
        v[1] := v[1] + 8 * cpf[3] + 7 * cpf[4] + 6 * cpf[5];
        v[1] := v[1] + 5 * cpf[6] + 4 * cpf[7] + 3 * cpf[8];
        v[1] := v[1] + 2 * v[0];
        v[1] := 11 - v[1] mod 11;
        v[1] := IfThen(v[1] >= 10, 0, v[1]);
        // Nota: Verdadeiro se os dígitos de verificação são os esperados.
        Result := ((v[0] = cpf[9]) and (v[1] = cpf[10]));
    except
        on E: Exception do
            Result := False;
    end;
end;

procedure TControllerFuncoes.limpaEdits(Form: Tform);
var
      I: integer;
begin

    for I := 0 to Form.ComponentCount - 1 do
        begin
            if (Form.Components[I] is TEdit) then
                TEdit(Form.Components[I]).Text := '';
            if (Form.Components[I] is TMaskEdit) then
                TMaskEdit(Form.Components[I]).Text := '';
            if (Form.Components[I] is TMemo) then
                TMemo(Form.Components[I]).Text := '';
            if (Form.Components[I] is TComboBox) then
                TComboBox(Form.Components[I]).Text := '';
        end;
end;

procedure TControllerFuncoes.fechaForms;
var
      n: integer;
begin
    for n := 0 to Application.ComponentCount - 1 do
        if Application.Components[n] is Tform then
            if not(Tform(Application.Components[n]) = Application.MainForm) then
                if Tform(Application.Components[n]).Showing then
                    begin
                        Tform(Application.Components[n]).Close;
                    end;

end;

end.
