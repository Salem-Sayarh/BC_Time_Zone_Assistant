// Table Extension - Customer Table
tableextension 50102 "Customer Table TZ" extends Customer
{
    fields
    {
        field(50100; TimeZoneIdentifier; Text[30])
        {
            Caption = 'Time Zone';
            Description = 'IANA format: Europe/Berlin';
        }
    }
}

// Page Extension - Customer Card
pageextension 50102 "Customer Card TZ" extends "Customer Card"
{
    layout
    {
        addlast(General)
        {
            field(TimeZoneIdentifier; Rec.TimeZoneIdentifier)
            {
                ApplicationArea = All;
                ToolTip = 'e.g., "Europe/Berlin" or "CET"';
                trigger OnValidate()
                begin
                    if Rec.TimeZoneIdentifier <> '' then
                        ValidateTimeZoneFormat(Rec.TimeZoneIdentifier);
                end;
            }
        }
    }
    local procedure ValidateTimeZoneFormat(TZIdentifier: Text)
    begin
        // Simple format check (allow 3-30 chars, letters/slashes)
        if not (TZIdentifier in ['A' .. 'Z', 'a' .. 'z', '/'])
           or (StrLen(TZIdentifier) < 3)
           or (StrLen(TZIdentifier) > 50) then
            Error('Invalid format. Use IANA (Europe/Berlin) or short codes (CET)');
    end;
}

// Page Extension - Customer List
pageextension 50103 "Customer List TZ" extends "Customer List"
{
    layout
    {
        addafter(Name)
        {
            field(TimeZoneIdentifier; Rec.TimeZoneIdentifier)
            {
                ApplicationArea = All;
                Visible = true;
            }
        }
    }
}
