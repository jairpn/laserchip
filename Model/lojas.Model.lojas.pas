unit lojas.Model.lojas;

interface

type
    TLojaModel = class
        private
            Fcnpj: string;
            Frazao_social: string;
            Fcodigo_loja: Integer;

            procedure Setcnpj(const Value: string);
            procedure Setcodigo_loja(const Value: Integer);
            procedure Setrazao_social(const Value: string);

        public
            constructor Create(ACodigo_Loja: Integer);
            property codigo_loja: Integer read Fcodigo_loja write Setcodigo_loja;
            property razao_social: string read Frazao_social write Setrazao_social;
            property cnpj: string read Fcnpj write Setcnpj;

    end;

implementation

{ TEmpresa }

constructor TLojaModel.Create(ACodigo_Loja: Integer);
begin
    Fcodigo_loja := ACodigo_Loja;
end;

procedure TLojaModel.Setcnpj(const Value: string);
begin
    Fcnpj := Value;
end;

procedure TLojaModel.Setcodigo_loja(const Value: Integer);
begin
    Fcodigo_loja := Value;
end;

procedure TLojaModel.Setrazao_social(const Value: string);
begin
    Frazao_social := Value;
end;

end.
