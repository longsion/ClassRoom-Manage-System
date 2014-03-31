unit FormManager;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ADODB, DB, StdCtrls, Grids, ComCtrls, jpeg, ExtCtrls;

type
  TManagerView = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Panel1: TPanel;
    Image1: TImage;
    StatusBar1: TStatusBar;
    StringGrid1: TStringGrid;
    Button4: TButton;
    Button5: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    ComboBox1: TComboBox;
    Label5: TLabel;
    ComboBox2: TComboBox;
    ComboBox3: TComboBox;
    Button6: TButton;
    Button7: TButton;
    Label6: TLabel;
    ComboBox4: TComboBox;
    Label7: TLabel;
    Label8: TLabel;
    Edit4: TEdit;
    Edit5: TEdit;
    Label9: TLabel;
    Edit6: TEdit;
    Button8: TButton;
    ADOQuery1: TADOQuery;
    ADOCommand1: TADOCommand;
    Label10: TLabel;
    Edit7: TEdit;
    Button9: TButton;
    Panel2: TPanel;
    StringGrid2: TStringGrid;
    Label11: TLabel;
    Edit8: TEdit;
    Label12: TLabel;
    Edit9: TEdit;
    Label13: TLabel;
    ComboBox5: TComboBox;
    ComboBox6: TComboBox;
    Label14: TLabel;
    Edit10: TEdit;
    Button10: TButton;
    Label15: TLabel;
    Edit11: TEdit;
    Label16: TLabel;
    Edit12: TEdit;
    Label17: TLabel;
    Label18: TLabel;
    Edit13: TEdit;
    ComboBox7: TComboBox;
    ComboBox8: TComboBox;
    Button11: TButton;
    Button12: TButton;
    Button13: TButton;
    Label19: TLabel;
    Edit14: TEdit;
    Label20: TLabel;
    Edit15: TEdit;
    Label21: TLabel;
    Edit16: TEdit;
    Label22: TLabel;
    Edit17: TEdit;
    Panel3: TPanel;
    StringGrid3: TStringGrid;
    StringGrid4: TStringGrid;
    Button14: TButton;
    Label23: TLabel;
    Label24: TLabel;
    Edit18: TEdit;
    Edit19: TEdit;
    Label27: TLabel;
    Edit22: TEdit;
    Label28: TLabel;
    Edit23: TEdit;
    Label29: TLabel;
    ComboBox9: TComboBox;
    Button15: TButton;
    Button16: TButton;
    Button17: TButton;
    Button18: TButton;
    Label30: TLabel;
    Edit24: TEdit;
    Label31: TLabel;
    Edit25: TEdit;
    Button19: TButton;
    Label32: TLabel;
    Edit26: TEdit;
    Label33: TLabel;
    Edit27: TEdit;
    Button20: TButton;
    Button21: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure StringGrid2SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure Button13Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button14Click(Sender: TObject);
    procedure Button15Click(Sender: TObject);
    procedure Button16Click(Sender: TObject);
    procedure Button19Click(Sender: TObject);
    procedure Button20Click(Sender: TObject);
    procedure Button21Click(Sender: TObject);
    procedure StringGrid3SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure StringGrid4SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure Button17Click(Sender: TObject);
    procedure Button18Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ManagerView: TManagerView;
  Currentrow:integer; //---����CurrentRowΪStringgrid�ĵ�ǰ��---
  currentrow2:integer;

implementation

uses FormLogin;

{$R *.dfm}
procedure TManagerView.Button10Click(Sender: TObject);
var
  i:integer;
begin
  button13.Visible:=false;//---��button13���ɼ�---
  adoquery1.Close;
  adoquery1.SQL.Clear;
  //-----�������пγ̵���Ϣ----
  adoquery1.sql.add('(select �γ̺�,�γ���,�̹���,ʱ��,���ұ��,ѧ��,ѧʱ from course)');
  if edit8.Text<>'' then
  //--������ҿγ̺ŵ���Ϣ---
    adoquery1.sql.add('intersect (select  �γ̺�,�γ���,�̹���,ʱ��,���ұ��,ѧ��,ѧʱ from course where �γ̺� like '''+'%'+edit8.Text+'%'+''')');
  if edit9.Text<>'' then
    adoquery1.sql.add('intersect (select  �γ̺�,�γ���,�̹���,ʱ��,���ұ��,ѧ��,ѧʱ from course where �γ��� like '''+'%'+edit9.Text+'%'+''')');
  if edit10.Text<>'' then
    adoquery1.sql.add('intersect (select  �γ̺�,�γ���,�̹���,ʱ��,���ұ��,ѧ��,ѧʱ from course where �̹��� like '''+'%'+edit10.Text+'%'+''')');
  if (combobox5.text<>'')  or (combobox6.Text<>'') then
    adoquery1.sql.add('intersect (select  �γ̺�,�γ���,�̹���,ʱ��,���ұ��,ѧ��,ѧʱ from course where ʱ�� like '''+'%'+combobox5.Text+combobox6.text+'%'+''')');
  adoquery1.Open;
  i:=1;
  while not adoquery1.Eof do      //-----�����ѯ���------
  begin
    stringgrid2.Cells[0,i]:=inttostr(i);
    stringgrid2.Cells[1,i]:=adoquery1.FieldByName('�γ̺�').AsString;
    stringgrid2.Cells[2,i]:=adoquery1.FieldByName('�γ���').AsString;
    stringgrid2.Cells[3,i]:=adoquery1.FieldByName('�̹���').AsString;
    stringgrid2.Cells[4,i]:=adoquery1.FieldByName('ʱ��').AsString;
    stringgrid2.Cells[5,i]:=adoquery1.FieldByName('���ұ��').AsString;
    stringgrid2.Cells[6,i]:=adoquery1.FieldByName('ѧ��').AsString;
    stringgrid2.Cells[7,i]:=adoquery1.FieldByName('ѧʱ').AsString;
    i:=i+1;
    adoquery1.Next;
  end;
  stringgrid2.rowCount:=i;
end;

procedure TManagerView.Button11Click(Sender: TObject);
begin
  button13.Visible:=false;
  if (edit11.Text='') or (edit12.Text='') or (edit13.Text='') or (edit14.Text='') or (combobox7.Text='') or (combobox8.Text='')  or( edit15.Text='')or (edit16.Text='') or(edit17.Text='') then
    showmessage('�����������Ŀγ���Ϣ')         //----��ʾ���������Ŀγ̵���Ϣ----
  else
  begin
    adoquery1.close;
    adoquery1.SQL.Clear;
    adoquery1.SQL.Add('select * from course where �γ̺�='''+edit11.text+'''');
    adoquery1.Open;
    if adoquery1.FieldByName('�γ̺�').AsString<>'' then
      showmessage('�ÿγ��Ѵ���')              //-----��ʾ�γ��Ѵ���
    else
    begin
      adoquery1.close;
      adoquery1.SQL.Clear;
      adoquery1.SQL.Add('select * from teacher where �̹���='''+edit12.text+'''');
      adoquery1.Open;
      if adoquery1.FieldByName('�̹���').AsString='' then
        showmessage('�ý�ʦ������')              //-----��ʾ��ʦ������
      else
      begin
        adoquery1.close;
        adoquery1.SQL.Clear;
        adoquery1.SQL.Add('select * from classroom where ���='''+edit14.text+'''');
        adoquery1.Open;
        if adoquery1.FieldByName('���').AsString='' then
          showmessage('�ý��Ҳ�����')              //-----��ʾ���Ҳ�����
        else
        begin
        //���뵽course ��
        adocommand1.CommandText:='insert into course values('''+edit11.text+''','''+edit13.text+''','''+edit17.text+''','''+edit16.text+''','''+edit15.text+''','''+edit12.Text+''','''+edit14.Text+''','''+combobox7.Text+combobox8.Text+''')';
        adocommand1.Execute;
        showmessage('��ӳɹ�');
        edit8.Text:='';        //---�������----
        edit9.Text:='';
        edit10.Text:='';
        combobox5.Text:='';
        combobox6.Text:='';
        button10.Click; //����button10
        end;
      end;
    end;

  end;

end;

procedure TManagerView.Button12Click(Sender: TObject);
begin
  button13.Visible:=false;
  if (edit11.Text='') or (edit12.Text='') or (edit13.Text='') or (edit14.Text='') or (combobox7.Text='') or (combobox8.Text='')  or( edit15.Text='')or (edit16.Text='') or(edit17.Text='') then
    showmessage('�����������Ŀγ���Ϣ')         //----��ʾ���������Ŀγ̵���Ϣ----
  else
  begin
    adoquery1.close;
    adoquery1.SQL.Clear;
    adoquery1.SQL.Add('select * from course where �γ̺�='''+edit11.text+'''');
    adoquery1.Open;
    if adoquery1.FieldByName('�γ̺�').AsString='' then
      showmessage('�ÿγ̲�����')              //-----��ʾ�γ��Ѵ���
    else
    begin
      adoquery1.close;
      adoquery1.SQL.Clear;
      adoquery1.SQL.Add('select * from teacher where �̹���='''+edit12.text+'''');
      adoquery1.Open;
      if adoquery1.FieldByName('�̹���').AsString='' then
        showmessage('�ý�ʦ������')              //-----��ʾ��ʦ������
      else
      begin
        adoquery1.close;
        adoquery1.SQL.Clear;
        adoquery1.SQL.Add('select * from classroom where ���='''+edit14.text+'''');
        adoquery1.Open;
        if adoquery1.FieldByName('���').AsString='' then
          showmessage('�ý��Ҳ�����')              //-----��ʾ���Ҳ�����
        else
        begin
        adocommand1.CommandText:='delete  from course where �γ̺�='''+edit11.text+'''';
        adocommand1.Execute;
        adocommand1.CommandText:='insert into course values('''+edit11.text+''','''+edit13.text+''','''+edit17.text+''','''+edit16.text+''','''+edit15.text+''','''+edit12.Text+''','''+edit14.Text+''','''+combobox7.Text+combobox8.Text+''')';
        adocommand1.Execute;
        showmessage('�޸ĳɹ�');
        edit8.Text:='';        //---�������----
        edit9.Text:='';
        edit10.Text:='';
        combobox5.Text:='';
        combobox6.Text:='';
        button10.Click; //����button10
        end;
      end;
    end;
  end;
end;

procedure TManagerView.Button13Click(Sender: TObject);
begin             //ɾ���γ���Ϣ
  adocommand1.CommandText:='delete from course where �γ̺�='''+stringgrid2.cells[1,currentrow]+'''';
  adocommand1.Execute;
  showmessage('ɾ���ɹ�');
  button10.Click;
end;

procedure TManagerView.Button14Click(Sender: TObject);   //---��ʦ��ѯ-----
begin
  button17.Visible:=false;
  stringgrid3.ColWidths[0]:=30;
  stringgrid3.ColWidths[1]:=75;
  stringgrid3.ColWidths[2]:=60;
  stringgrid3.ColWidths[3]:=80;
  stringgrid3.ColWidths[4]:=145;
  stringgrid3.ColWidths[5]:=60;
  stringgrid3.Cells[0,0]:='���';
  stringgrid3.Cells[1,0]:='�̹���';
  stringgrid3.Cells[2,0]:='����';
  stringgrid3.Cells[3,0]:='�绰';
  stringgrid3.Cells[4,0]:='����';
  stringgrid3.Cells[5,0]:='�ȼ�';
  adoquery1.Close;
  adoquery1.SQL.Clear;
  adoquery1.SQL.Add('(select * from teacher)');
  if edit18.Text<>'' then
    adoquery1.SQL.Add('intersect (select * from teacher where teacher.�̹��� like '''+'%'+edit18.text+'%'+''')');
  if edit19.Text<>'' then
    adoquery1.SQL.Add('intersect (select * from teacher where teacher.���� like '''+'%'+edit19.text+'%'+''')');
  adoquery1.Open;
  stringgrid3.RowCount:=1;
  while not adoquery1.Eof do
  begin
    stringgrid3.Cells[0,stringgrid3.RowCount]:=inttostr(stringgrid3.RowCount);
    stringgrid3.Cells[1,stringgrid3.RowCount]:=adoquery1.FieldByName('�̹���').Asstring;
    stringgrid3.Cells[2,stringgrid3.RowCount]:=adoquery1.FieldByName('����').AsString;
    stringgrid3.Cells[3,stringgrid3.RowCount]:=adoquery1.FieldByName('�绰').AsString;
    stringgrid3.Cells[4,stringgrid3.RowCount]:=adoquery1.FieldByName('����').AsString;
    stringgrid3.Cells[5,stringgrid3.RowCount]:=adoquery1.FieldByName('�ȼ�').AsString;
    stringgrid3.RowCount:=stringgrid3.RowCount+1;
    adoquery1.Next;
  end;
end;

procedure TManagerView.Button15Click(Sender: TObject);    //----��ӽ�ʦ��Ϣ---
begin
  if (edit18.Text='') or (edit19.text='') or (Combobox9.Text='') then
    showmessage('�̹��ţ���ʦ�������ȼ���Ϣ��������')      //-----��ʾ������Ϣ������������Ϣ--
  else
  begin
    adoquery1.Close;
    adoquery1.SQL.Clear;
    adoquery1.SQL.Add('select * from teacher where �̹���='''+edit18.text+'''');
    adoquery1.Open;
    if adoquery1.FieldByName('�̹���').AsString<>'' then
      showmessage('�ý̹����Ѵ���') //----��ʾ�̹����Ѵ��ڵ���Ϣ----
    else
    begin                      //-----�����ʦ��Ϣ----
      //----���ó�ʼ����Ϊ123
      adocommand1.CommandText:='insert into teacher values('''+edit18.Text+''','''+edit19.Text+''','''+edit22.Text+''','''+edit23.Text+''','''+combobox9.text+''',''123'')';
      adocommand1.Execute;
      showmessage('��ӽ�ʦ�ɹ�');
      button14.Click; //-----����Button14-----
    end;
  end;
end;

procedure TManagerView.Button16Click(Sender: TObject);
begin
  if (edit18.Text='') or (edit19.text='') or (Combobox9.Text='') then
    showmessage('�̹��ţ���ʦ�������ȼ���Ϣ��������')      //-----��ʾ������Ϣ������������Ϣ--
  else
  begin
    adoquery1.Close;
    adoquery1.SQL.Clear;
    adoquery1.SQL.Add('select * from teacher where �̹���='''+edit18.text+'''');
    adoquery1.Open;
    if adoquery1.FieldByName('�̹���').AsString='' then
      showmessage('�ý̹��Ų�����') //----��ʾ�̹��Ų����ڵ���Ϣ----
    else
    begin                      //-----�޸Ľ�ʦ��Ϣ----
      adocommand1.CommandText:='update teacher set ����='''+edit19.Text+''' where �̹���='''+edit18.text+'''';
      adocommand1.Execute;
      adocommand1.CommandText:='update teacher set �绰='''+edit22.Text+''' where �̹���='''+edit18.text+'''';
      adocommand1.Execute;
      adocommand1.CommandText:='update teacher set �ȼ�='''+combobox9.Text+''' where �̹���='''+edit18.text+'''';
      adocommand1.Execute;
      adocommand1.CommandText:='update teacher set ����='''+edit23.Text+''' where �̹���='''+edit18.text+'''';
      adocommand1.Execute;
      showmessage('�޸ĳɹ�');
      button14.Click; //-----����Button14-----
    end;
  end;
end;

procedure TManagerView.Button17Click(Sender: TObject);  //-----ɾ����ʦ��Ϣ----
begin             //ɾ����ʦ��Ϣ
  adocommand1.CommandText:='delete from teacher where �̹���='''+stringgrid3.cells[1,currentrow]+'''';
  adocommand1.Execute;
  adocommand1.CommandText:='update course set �̹���='''+''' where �̹���='''+stringgrid3.cells[1,currentrow]+'''';
  adocommand1.Execute;
  adocommand1.CommandText:='delete from tea_classroom where �̹���='''+stringgrid3.cells[1,currentrow]+'''';
  adocommand1.Execute;
  showmessage('ɾ���ɹ�');
  button14.Click;

end;

procedure TManagerView.Button18Click(Sender: TObject);
begin             //ɾ��ѧ����Ϣ
  adocommand1.CommandText:='delete from student where ѧ��='''+stringgrid4.cells[1,currentrow2]+'''';
  adocommand1.Execute;
  adocommand1.CommandText:='delete from cou_student where ѧ��='''+stringgrid4.cells[1,currentrow2]+'''';
  adocommand1.Execute;
  adocommand1.CommandText:='delete from stu_classroom where ѧ��='''+stringgrid4.cells[1,currentrow2]+'''';
  adocommand1.Execute;
  showmessage('ɾ���ɹ�');
  button19.Click;
end;

procedure TManagerView.Button19Click(Sender: TObject);   //-----��ѯѧ����Ϣ------
begin
  button18.Visible:=false;
  stringgrid4.ColWidths[0]:=40;
  stringgrid4.ColWidths[1]:=135;
  stringgrid4.ColWidths[2]:=80;
  stringgrid4.ColWidths[3]:=90;
  stringgrid4.ColWidths[4]:=100;
  stringgrid4.Cells[0,0]:='���';
  stringgrid4.Cells[1,0]:='ѧ��';
  stringgrid4.Cells[2,0]:='����';
  stringgrid4.Cells[3,0]:='�༶';
  stringgrid4.Cells[4,0]:='ѧԺ';
  adoquery1.Close;
  adoquery1.SQL.Clear;
  adoquery1.SQL.Add('(select * from student)');
  if edit24.Text<>'' then
    adoquery1.SQL.Add('intersect (select * from student where ѧ�� like '''+'%'+edit24.text+'%'+''')');
  if edit25.Text<>'' then
    adoquery1.SQL.Add('intersect (select * from student where ���� like '''+'%'+edit25.text+'%'+''')');
  if edit26.Text<>'' then
    adoquery1.SQL.Add('intersect (select * from student where �༶ like '''+'%'+edit26.text+'%'+''')');
  if edit27.Text<>'' then
    adoquery1.SQL.Add('intersect (select * from student where ѧԺ like '''+'%'+edit27.text+'%'+''')');
  adoquery1.Open;
  stringgrid4.RowCount:=1;
  while not adoquery1.Eof do
  begin
    stringgrid4.Cells[0,stringgrid4.RowCount]:=inttostr(stringgrid4.RowCount);
    stringgrid4.Cells[1,stringgrid4.RowCount]:=adoquery1.FieldByName('ѧ��').AsString;
    stringgrid4.Cells[2,stringgrid4.RowCount]:=adoquery1.FieldByName('����').AsString;
    stringgrid4.Cells[3,stringgrid4.RowCount]:=adoquery1.FieldByName('�༶').AsString;
    stringgrid4.Cells[4,stringgrid4.RowCount]:=adoquery1.FieldByName('ѧԺ').AsString;
    stringgrid4.RowCount:=stringgrid4.RowCount+1;
    adoquery1.Next;
  end;
end;

procedure TManagerView.Button1Click(Sender: TObject);
begin
  panel1.Visible:=true;   //------ʹPanel1�ɼ�-----
  panel2.Visible:=false;
  panel3.Visible:=false;
  if stringgrid1.ColCount=5 then
    button4.Click  //�������Ҳ�ѯ
  else
    button5.Click;  //��������ʹ�ò�ѯ
end;

procedure TManagerView.Button20Click(Sender: TObject);       //----���ѧ����Ϣ-----
begin
  if (edit24.Text='') or (edit25.text='') or (edit26.Text='') or(edit27.Text='') then
    showmessage('ѧ����Ϣ��������')      //-----��ʾ������Ϣ������������Ϣ--
  else
  begin
    adoquery1.Close;
    adoquery1.SQL.Clear;
    adoquery1.SQL.Add('select * from student where ѧ��='''+edit24.text+'''');
    adoquery1.Open;
    if adoquery1.FieldByName('ѧ��').AsString<>'' then
      showmessage('��ѧ���Ѵ���') //----��ʾѧ���Ѵ��ڵ���Ϣ----
    else
    begin                      //-----����ѧ����Ϣ----
      //----���ó�ʼ����Ϊ123
      adocommand1.CommandText:='insert into student values('''+edit24.Text+''','''+edit25.Text+''','''+edit26.Text+''','''+edit27.Text+''',''123'')';
      adocommand1.Execute;
      showmessage('���ѧ���ɹ�');
      button19.Click; //-----����Button19-----
    end;
  end;
end;

procedure TManagerView.Button21Click(Sender: TObject);    //----�޸�ѧ����Ϣ
begin
  if (edit24.Text='') or (edit25.text='') or (edit26.Text='') or(edit27.Text='') then
    showmessage('ѧ����Ϣ��������')      //-----��ʾ������Ϣ������������Ϣ--
  else
  begin
    adoquery1.Close;
    adoquery1.SQL.Clear;
    adoquery1.SQL.Add('select * from student where ѧ��='''+edit24.text+'''');
    adoquery1.Open;
    if adoquery1.FieldByName('ѧ��').AsString='' then
      showmessage('��ѧ�Ų�����') //----��ʾѧ�Ų����ڵ���Ϣ----
    else
    begin                      //-----�޸�ѧ����Ϣ----
      adocommand1.CommandText:='update student set ����='''+edit25.Text+''' where ѧ��='''+edit24.text+'''';
      adocommand1.Execute;
      adocommand1.CommandText:='update student set �༶='''+edit26.Text+''' where ѧ��='''+edit24.text+'''';
      adocommand1.Execute;
      adocommand1.CommandText:='update student set ѧԺ='''+edit27.Text+''' where ѧ��='''+edit24.text+'''';
      adocommand1.Execute;
      showmessage('�޸ĳɹ�');
      button19.Click; //-----����Button19-----
    end;
  end;
end;

procedure TManagerView.Button2Click(Sender: TObject);
begin
  panel1.Visible:=false;     //------��ʾpanel2------
  panel2.Visible:=true;
  panel3.Visible:=false;
  stringgrid2.Cells[0,0]:='���';
  stringgrid2.Cells[1,0]:='�γ̺�';
  stringgrid2.Cells[2,0]:='�γ���';
  stringgrid2.Cells[3,0]:='�̹���';
  stringgrid2.Cells[4,0]:='�γ�ʱ��';
  stringgrid2.Cells[5,0]:='���ұ��';
  stringgrid2.Cells[6,0]:='ѧ��';
  stringgrid2.Cells[7,0]:='ѧʱ';
  stringgrid2.ColWidths[0]:=50;
  stringgrid2.ColWidths[1]:=150;
  stringgrid2.ColWidths[2]:=150;
  stringgrid2.ColWidths[3]:=100;
  stringgrid2.ColWidths[4]:=100;
  stringgrid2.ColWidths[5]:=100;
  stringgrid2.ColWidths[6]:=65;
  stringgrid2.ColWidths[7]:=65;
  button10.Click;  //----�൱�ڴ�����button10(��ѯ��ť��---
end;

procedure TManagerView.Button3Click(Sender: TObject);
begin
  panel1.Visible:=false;
  panel2.Visible:=false;
  panel3.Visible:=true;
  button14.Click;
  button19.Click;       //----����button14��button19
end;

procedure TManagerView.Button4Click(Sender: TObject);  //----���Ҳ�ѯ-----
begin
  button6.Visible:=false;
  button7.Visible:=false;
  stringgrid1.ColCount:=5;              //-----����stringgrid���������п�----
  stringgrid1.Cells[0,0]:='���';
  stringgrid1.Cells[1,0]:='���ұ��';
  stringgrid1.Cells[2,0]:='��������';
  stringgrid1.Cells[3,0]:='����';
  stringgrid1.Cells[4,0]:='��������';
  stringgrid1.ColWidths[0]:=40;
  stringgrid1.ColWidths[1]:=90;
  stringgrid1.ColWidths[2]:=165;
  stringgrid1.ColWidths[3]:=60;
  stringgrid1.ColWidths[4]:=165;
  adoquery1.Close;
  adoquery1.SQL.Clear;
  adoquery1.SQL.Add('(select * from classroom)');
  if combobox1.Text<>'' then
    adoquery1.SQL.Add('intersect (select * from classroom where ���� like '''+'%'+combobox1.Text+'%'+''')');
  if edit1.Text<>'' then
    adoquery1.SQL.Add('intersect (select * from classroom where ����>= '+edit1.text+')');
  if edit2.Text<>'' then
    adoquery1.SQL.Add('intersect (select * from classroom where ����<= '+edit2.text+')');
  if edit3.Text<>'' then
    adoquery1.SQL.Add('intersect (select * from classroom where ��� like '''+'%'+edit3.Text+'%'+''')');
  if edit7.Text<>'' then
    adoquery1.SQL.Add('intersect (select * from classroom where ���� like '''+'%'+edit7.Text+'%'+''')');
  adoquery1.Open;
  stringgrid1.Rowcount:=1;          //---�����ݴ���stringdrid��-----
  while not adoquery1.Eof do
  begin
    stringgrid1.Cells[0,stringgrid1.RowCount]:=inttostr(stringgrid1.RowCount);
    stringgrid1.Cells[1,stringgrid1.RowCount]:=adoquery1.fieldbyname('���').AsString;
    stringgrid1.Cells[2,stringgrid1.RowCount]:=adoquery1.fieldbyname('����').AsString;
    stringgrid1.Cells[3,stringgrid1.RowCount]:=adoquery1.fieldbyname('����').AsString;
    stringgrid1.Cells[4,stringgrid1.RowCount]:=adoquery1.fieldbyname('����').AsString;
    stringgrid1.RowCount:=stringgrid1.RowCount+1;
    adoquery1.Next;
  end;
end;

procedure TManagerView.Button5Click(Sender: TObject);
   //----����ʹ�ò�ѯ------
var
  i:integer;
  temp:string;
begin
  button6.Visible:=false;
  button7.Visible:=false;
  stringgrid1.ColCount:=6;              //-----����stringgrid���������п�----
  stringgrid1.Cells[0,0]:='���';
  stringgrid1.Cells[1,0]:='���ұ��';
  stringgrid1.Cells[2,0]:='��������';
  stringgrid1.Cells[3,0]:='ʹ�ö���';
  stringgrid1.Cells[4,0]:='������';
  stringgrid1.Cells[5,0]:='ʹ��ʱ��';
  stringgrid1.ColWidths[0]:=40;
  stringgrid1.ColWidths[1]:=80;
  stringgrid1.ColWidths[2]:=110;
  stringgrid1.ColWidths[3]:=75;
  stringgrid1.ColWidths[4]:=115;
  stringgrid1.ColWidths[5]:=85;
  temp:=combobox2.Text+combobox3.Text;
  adoquery1.Close;               //-----��ѯ������ѧ�����ý��ҵ���Ϣ-------
  adoquery1.SQL.Clear;
  if (combobox2.Text<>'') or (combobox3.Text<>'')  then
    adoquery1.SQL.Add('(select ���,����,ѧ��,����ʱ�� from classroom ,stu_classroom where  stu_classroom.����ʱ�� like'''+'%'+temp+'%'+''' and stu_classroom.���ұ��=classroom.���) ')
  else
    adoquery1.SQL.Add('(select ���,����,ѧ��,����ʱ�� from classroom ,stu_classroom where classroom.���=stu_classroom.���ұ��)');
  if (combobox1.text<>'') and (combobox1.Text<>' ') then
    adoquery1.SQL.Add('intersect (select ���,����,ѧ��,����ʱ�� from classroom ,stu_classroom where classroom.���� like '''+'%'+combobox1.text+'%'+'''and stu_classroom.���ұ��=classroom.���) ');
  if (edit1.Text<>'') and (edit1.Text<>' ') then
    adoquery1.SQL.Add('intersect (select ���,����,ѧ��,����ʱ�� from classroom ,stu_classroom where classroom.����>='+edit1.text+'and stu_classroom.���ұ��=classroom.���) ');
  if (edit2.Text<>'') and (edit2.Text<>' ') then
    adoquery1.SQL.Add('intersect (select ���,����,ѧ��,����ʱ�� from classroom ,stu_classroom where classroom.����<='+edit2.text+'and stu_classroom.���ұ��=classroom.���) ');
  if (edit3.Text<>'') and (edit3.Text<>' ') then
    adoquery1.SQL.Add('intersect (select ���,����,ѧ��,����ʱ�� from classroom ,stu_classroom where stu_classroom.���ұ��=classroom.��� and classroom.��� like '''+'%'+edit3.Text+'%'+''')');
  if (edit7.Text<>'') and (edit7.Text<>' ') then
    adoquery1.SQL.Add('intersect (select ���,����,ѧ��,����ʱ�� from classroom ,stu_classroom where stu_classroom.���ұ��=classroom.��� and classroom.���� like '''+'%'+edit7.Text+'%'+''')');
  adoquery1.Open;
  i:=1;
  while not adoquery1.Eof do
  begin
    stringgrid1.Cells[0,i]:=inttostr(i);
    stringgrid1.Cells[1,i]:=adoquery1.FieldByName('���').AsString;
    stringgrid1.Cells[2,i]:=adoquery1.FieldByName('����').AsString;
    stringgrid1.Cells[3,i]:='ѧ��';
    stringgrid1.Cells[4,i]:=adoquery1.FieldByName('ѧ��').AsString;
    stringgrid1.Cells[5,i]:=adoquery1.FieldByName('����ʱ��').AsString;
    i:=i+1;
    adoquery1.Next;
  end;
  adoquery1.Close;                //-----��ѯ�������ʦ���ý��ҵ���Ϣ-------
  adoquery1.SQL.Clear;
  if (combobox2.Text<>'') or (combobox3.Text<>'')  then
    adoquery1.SQL.Add('(select ���,����,�̹���,����ʱ�� from classroom ,tea_classroom where  tea_classroom.����ʱ��  like'''+'%'+temp+'%'+''' and tea_classroom.���ұ��=classroom.���) ')
  else
    adoquery1.SQL.Add('(select ���,����,�̹���,����ʱ�� from classroom ,tea_classroom where classroom.���=tea_classroom.���ұ��)');
  if (combobox1.text<>'') and (combobox1.Text<>' ') then
    adoquery1.SQL.Add('intersect (select ���,����,�̹���,����ʱ�� from classroom ,tea_classroom where classroom.���� like '''+'%'+combobox1.text+'%'+'''and tea_classroom.���ұ��=classroom.���) ');
  if (edit1.Text<>'') and (edit1.Text<>' ') then
    adoquery1.SQL.Add('intersect (select ���,����,�̹���,����ʱ�� from classroom ,tea_classroom where classroom.����>='+edit1.text+'and tea_classroom.���ұ��=classroom.���) ');
  if (edit2.Text<>'') and (edit2.Text<>' ') then
    adoquery1.SQL.Add('intersect (select ���,����,�̹���,����ʱ�� from classroom ,tea_classroom where classroom.����<='+edit2.text+'and tea_classroom.���ұ��=classroom.���) ');
  if (edit3.Text<>'') and (edit3.Text<>' ') then
    adoquery1.SQL.Add('intersect(select ���,����,�̹���,����ʱ�� from classroom ,tea_classroom where tea_classroom.���ұ��=classroom.��� and classroom.��� like '''+'%'+edit3.Text+'%'+''')');
  if (edit7.Text<>'') and (edit7.Text<>' ') then
    adoquery1.SQL.Add('intersect(select ���,����,�̹���,����ʱ�� from classroom ,tea_classroom where tea_classroom.���ұ��=classroom.��� and classroom.���� like '''+'%'+edit7.Text+'%'+''')');
  adoquery1.Open;
  while not adoquery1.Eof do
  begin
    stringgrid1.Cells[0,i]:=inttostr(i);
    stringgrid1.Cells[1,i]:=adoquery1.FieldByName('���').AsString;
    stringgrid1.Cells[2,i]:=adoquery1.FieldByName('����').AsString;
    stringgrid1.Cells[3,i]:='��ʦ';
    stringgrid1.Cells[4,i]:=adoquery1.FieldByName('�̹���').AsString;
    stringgrid1.Cells[5,i]:=adoquery1.FieldByName('����ʱ��').AsString;
    i:=i+1;
    adoquery1.Next;
  end;
  adoquery1.Close;                  //-----��ѯ������γ�ռ�ý��ҵ���Ϣ-------
  adoquery1.SQL.Clear;
  if (combobox2.Text<>'') or (combobox3.Text<>'') then
    adoquery1.SQL.Add('(select  ���,����,�γ̺�,ʱ�� from classroom ,course where  ʱ�� like'''+'%'+temp+'%'+'''  and ���ұ��=classroom.���) ')
  else
    adoquery1.SQL.Add('(select  ���,����,�γ̺�,ʱ�� from classroom ,course where ���=���ұ��)');
  if (combobox1.text<>'') and (combobox1.Text<>' ') then
    adoquery1.SQL.Add('intersect (select  ���,����,�γ̺�,ʱ�� from classroom ,course where classroom.���� like '''+'%'+combobox1.text+'%'+'''and ���ұ��=classroom.���) ');
  if (edit1.Text<>'') and (edit1.Text<>' ') then
    adoquery1.SQL.Add('intersect (select  ���,����,�γ̺�,ʱ�� from classroom ,course where classroom.����>='+edit1.text+'and ���ұ��=classroom.���) ');
  if (edit2.Text<>'') and (edit2.Text<>' ') then
    adoquery1.SQL.Add('intersect (select  ���,����,�γ̺�,ʱ�� from classroom ,course where classroom.����<='+edit2.text+'and ���ұ��=classroom.���) ');
  if (edit3.Text<>'') and (edit3.Text<>' ') then
    adoquery1.SQL.Add('intersect (select  ���,����,�γ̺�,ʱ�� from classroom ,course where cou_student.���ұ��=classroom.��� and classroom.��� like '''+'%'+edit3.Text+'%'+''')');
  if (edit7.Text<>'') and (edit7.Text<>' ') then
    adoquery1.SQL.Add('intersect (select  ���,����,�γ̺�,ʱ�� from classroom ,course where cou_student.���ұ��=classroom.��� and classroom.���� like '''+'%'+edit7.Text+'%'+''')');
  adoquery1.Open;
  while not adoquery1.Eof do
  begin
    stringgrid1.Cells[0,i]:=inttostr(i);
    stringgrid1.Cells[1,i]:=adoquery1.FieldByName('���').AsString;
    stringgrid1.Cells[2,i]:=adoquery1.FieldByName('����').AsString;
    stringgrid1.Cells[3,i]:='�γ�';
    stringgrid1.Cells[4,i]:=adoquery1.FieldByName('�γ̺�').AsString;
    stringgrid1.Cells[5,i]:=adoquery1.FieldByName('ʱ��').AsString;
    i:=i+1;
    adoquery1.Next;
  end;
  stringgrid1.RowCount:=i;  //---��stringgrid��������Ϊi

end;


procedure TManagerView.Button6Click(Sender: TObject);
begin
  //---ɾ�����ұ��еĽ�����Ϣ----
  adocommand1.CommandText:='delete from classroom where ���='''+stringgrid1.Cells[1,CurrentRow]+'''';
  adocommand1.Execute;
  //----ɾ��Stu_classroom�е���Ϣ----
  adocommand1.CommandText:='delete from stu_classroom where ���ұ��='''+stringgrid1.Cells[1,CurrentRow]+'''';
  adocommand1.Execute;
  //----ɾ��Tea_classroom�е���Ϣ----
  adocommand1.CommandText:='delete from tea_classroom where ���ұ��='''+stringgrid1.Cells[1,CurrentRow]+'''';
  adocommand1.Execute;
  //----���¿γ���Ϣ----
  adocommand1.CommandText:='update course set ���ұ��='''+''' where ���ұ��='''+stringgrid1.Cells[1,CurrentRow]+'''';
  adocommand1.Execute;
  showmessage('ɾ���ɹ�');
  button4.Click;  //---����Stringgrid�е�����----
end;

procedure TManagerView.Button7Click(Sender: TObject);
begin
  if stringgrid1.Cells[3,currentrow]='ѧ��' then
  begin
    adocommand1.CommandText:='delete from stu_classroom where ���ұ��='''+stringgrid1.Cells[1,CurrentRow]+''' and ѧ��='''+stringgrid1.cells[4,currentRow]+''' and ����ʱ��='''+stringgrid1.cells[5,currentrow]+'''';
    adocommand1.Execute;
  end;
  if stringgrid1.Cells[3,currentrow]='��ʦ' then
  begin
    adocommand1.CommandText:='delete from tea_classroom where ���ұ��='''+stringgrid1.Cells[1,CurrentRow]+''' and �̹���='''+stringgrid1.cells[4,currentRow]+''' and ����ʱ��='''+stringgrid1.cells[5,currentrow]+'''';
    adocommand1.Execute;
  end;
  showmessage('ɾ���ɹ�');
  button5.Click;  //-----����stringgrid�е�����------
end;


procedure TManagerView.Button8Click(Sender: TObject);         //----��������-----
begin
  button6.Visible:=false;
  button7.Visible:=false;
  if (combobox4.Text='') or (edit4.Text='') or(edit5.Text='') or (edit6.Text='') then
    showmessage('�����������Ľ�����Ϣ')             //----��ʾ���������Ľ�����Ϣ----
  else
  begin
    adoquery1.close;
    adoquery1.sql.Clear;
    adoquery1.SQL.Add('select * from classroom where classroom.���='''+edit5.text+'''');
    adoquery1.Open;
    if adoquery1.FieldByName('���').AsString<>'' then     //---����ý��ұ�Ŵ��ڣ���ʾ��Ϣ
      showmessage('�ý����Ѵ���')
    else
    begin                               //----����½���----
      adocommand1.CommandText:='insert into classroom values('''+edit5.text+''','''+edit6.text+''','''+edit4.text+''','''+combobox4.text+''')';
      adocommand1.Execute;
      showmessage('��ӳɹ�');
      //-----�������------
      combobox1.Text:='';
      combobox2.Text:='';
      combobox3.Text:='';
      edit1.Text:='';
      edit2.Text:='';
      edit3.Text:='';
      edit7.Text:='';
      button4.Click;  //-----ˢ��Stringgrid�е�����-------
    end;
  end;

end;

procedure TManagerView.Button9Click(Sender: TObject);
begin
  button6.Visible:=false;
  button7.Visible:=false;
  if (combobox4.Text='') or (edit4.Text='') or(edit5.Text='') or (edit6.Text='') then
    showmessage('�����������Ľ�����Ϣ')             //----��ʾ���������Ľ�����Ϣ----
  else
  begin
    adoquery1.close;
    adoquery1.sql.Clear;
    adoquery1.SQL.Add('select * from classroom where classroom.���='''+edit5.text+'''');
    adoquery1.Open;
    if adoquery1.FieldByName('���').AsString='' then     //---����ý��ұ�Ų����ڣ���ʾ��Ϣ
      showmessage('�ý��Ҳ�����')
    else
    begin                               //----�޸Ľ���----
      adocommand1.CommandText:='update classroom set ����='''+edit6.Text+''' where ���='''+edit5.Text+'''';
      adocommand1.Execute;
      adocommand1.CommandText:='update classroom set ����='''+edit4.Text+''' where ���='''+edit5.Text+'''';
      adocommand1.Execute;
      adocommand1.CommandText:='update classroom set ����='''+combobox4.Text+''' where ���='''+edit5.Text+'''';
      adocommand1.Execute;
      showmessage('�޸ĳɹ�');
      //-----�������------
      combobox1.Text:='';
      combobox2.Text:='';
      combobox3.Text:='';
      edit1.Text:='';
      edit2.Text:='';
      edit3.Text:='';
      edit7.Text:='';
      button4.Click;  //-----ˢ��Stringgrid�е�����-------
    end;
  end;

end;

procedure TManagerView.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Login.close;//---�ر���������----
end;

procedure TManagerView.FormShow(Sender: TObject);
begin
  button1.Click;      //-----����Button1
end;

procedure TManagerView.StringGrid1SelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);//------------------ѡ��stringgrid�е����ݣ��ж��Ƿ���ʾ��ɾ�����ҡ���ɾ��ʹ�á��İ�ť
begin
  CurrentRow:=ARow;
  if ARow=0 then                  //----�����ǰ���ǵ�һ�У������������������ɼ�-----
  begin
    button6.Visible:=false;
    button7.Visible:=false;
  end
  else if stringgrid1.ColCount=5 then
  begin                          //----�������Ϊ5������ʾ���Ҳ�ѯʱ�����á�ɾ�����ҡ���ť�ɼ�����ɾ��ʹ�á���ť���ɼ�
    button6.Visible:=true;
    button7.Visible:=false;
    edit5.Text:=stringgrid1.Cells[1,ARow];
    edit6.Text:=stringgrid1.Cells[2,ARow];
    edit4.Text:=stringgrid1.Cells[3,ARow];
    combobox4.Text:=stringgrid1.Cells[4,ARow];
  end
  else                    //----���������Ϊ5������ʾ����ʹ�ò�ѯʱ�����á�ɾ�����ҡ���ť���ɼ�����ɾ��ʹ�á���ť�ɼ�
  begin
    if stringgrid1.Cells[3,ARow]='�γ�' then  //----����ǿγ�ռ�õ�ʱ��  �򲻿�ɾ����������ʾ��
      button7.Visible:=false
    else
    begin
      button6.Visible:=false;
      button7.Visible:=true;
    end;
  end;

end;

procedure TManagerView.StringGrid2SelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  CurrentRow:=ARow;
  if ARow=0 then                  //----�����ǰ���ǵ�һ�У�����ɾ����ť���ɼ�-----
  begin
    button13.Visible:=false;
  end
  else                     //----ʹ��ɾ������ť�ɼ�
  begin
    button13.Visible:=true;
    edit11.Text:=stringgrid2.Cells[1,ARow];
    edit13.Text:=stringgrid2.Cells[2,ARow];
    edit12.Text:=stringgrid2.Cells[3,ARow];
    edit14.Text:=stringgrid2.Cells[5,ARow];
    edit16.Text:=stringgrid2.Cells[6,ARow];
    edit17.Text:=stringgrid2.Cells[7,ARow];
  end;
end;

procedure TManagerView.StringGrid3SelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  CurrentRow:=ARow;
  if ARow=0 then                  //----�����ǰ���ǵ�һ�У�����ɾ����ť���ɼ�-----
  begin
    button17.Visible:=false;
  end
  else                     //----ʹ��ɾ����ʦ����ť�ɼ�
  begin
    edit18.Text:=stringgrid3.Cells[1,ARow];      //----��ѡ�е���Ϣ����edit����---
    edit19.Text:=stringgrid3.Cells[2,ARow];
    edit22.Text:=stringgrid3.Cells[3,ARow];
    edit23.Text:=stringgrid3.Cells[4,ARow];
    combobox9.Text:=stringgrid3.Cells[5,ARow];
    button17.Visible:=true;
  end;
end;

procedure TManagerView.StringGrid4SelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  CurrentRow2:=ARow;
  if ARow=0 then                  //----�����ǰ���ǵ�һ�У�����ɾ����ť���ɼ�-----
  begin
    button18.Visible:=false;
  end
  else                     //----ʹ��ɾ��ѧ������ť�ɼ�
  begin
    edit24.Text:=stringgrid4.Cells[1,ARow];      //----��ѡ�е���Ϣ����edit����---
    edit25.Text:=stringgrid4.Cells[2,ARow];
    edit26.Text:=stringgrid4.Cells[3,ARow];
    edit27.Text:=stringgrid4.Cells[4,ARow];
    button18.Visible:=true;
  end;
end;

end.
