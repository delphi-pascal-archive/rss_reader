unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  StdCtrls,MSXML;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    ComboBox1: TComboBox;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  URL: string;
  
implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
 CityID: string;
 CoDoc: CoDOMDocument;
 XMLD: DOMDocument;
 r: IXMLDOMElement; // ���������� �������� DOMElement
 FNode: IXMLDOMNode;
 i,y: integer;
begin
 XMLD:=CoDoc.Create ;
 XMLD.async:=false; // ���� true �� ����� ����������� ����� ����������  XML � �����:)
 URL:=ComboBox1.Text;
 XMLD.load(URL); // ��� ������������ ���� ��� ����� XMLD.load('test.txt');
 // ����� ��������� �� ��� ����������� � �������
 // XMLD.save('FindCityXML.txt');
 memo1.Clear;
 // �������� ���������� �� ������������ � ����� XML'�
 r:=XMLD.documentElement;
 FNode:= r.SelectSingleNode('//rss');
 if FNode.attributes.getNamedItem('version').text<>'2.0'
 then
  begin
   Memo1.Lines.Add('������ - ��� ������ ��������� ������������ RSS ������ ������ 2.0');
   Exit;
  end;
 FNode:= FNode.SelectSingleNode('//channel');
 Memo1.Lines.Add('Info: ');
 Memo1.Lines.Add('��������� - ' + FNode.selectSingleNode('//title').text);
 Memo1.Lines.Add('�������� - ' + FNode.selectSingleNode('//copyright').text);
 Memo1.Lines.Add('���� ���������� �������� - '+FNode.selectSingleNode('//lastBuildDate').text);
 Memo1.Lines.Add('');
 Memo1.Lines.Add('News: ');
 for i:=0 to FNode.selectNodes('//item').length-1 do
  begin
   Memo1.Lines.Add('������� - ' + FNode.selectNodes('//item').item[i].childNodes.item[0].text);
   Memo1.Lines.Add('������ - ' + FNode.selectNodes('//item').item[i].childNodes.item[1].text);
   Memo1.Lines.Add('');
  end;
end;

end.
