unit FormStudent;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, jpeg, ExtCtrls, ButtonGroup, StdCtrls, Grids, DBGrids,
  Buttons, DB, ADODB;

type
  TStudentView = class(TForm)
    StatusBar1: TStatusBar;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    Panel1: TPanel;
    Label1: TLabel;
    Edit1: TEdit;
    ComboBox1: TComboBox;
    Label2: TLabel;
    Label3: TLabel;
    Edit2: TEdit;
    Edit3: TEdit;
    Label4: TLabel;
    ComboBox2: TComboBox;
    ComboBox3: TComboBox;
    Label5: TLabel;
    Button1: TButton;
    Button2: TButton;
    ADOQuery1: TADOQuery;
    Image1: TImage;
    ADOCommand1: TADOCommand;
    StringGrid1: TStringGrid;
    Button3: TButton;
    Panel2: TPanel;
    Label6: TLabel;
    Label7: TLabel;
    Edit4: TEdit;
    Edit5: TEdit;
    StringGrid2: TStringGrid;
    Button4: TButton;
    Panel3: TPanel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    ComboBox4: TComboBox;
    ComboBox5: TComboBox;
    Button5: TButton;
    StringGrid3: TStringGrid;
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure ComboBox3Change(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  StudentView: TStudentView;
  currentRow:integer;

implementation

uses FormLogin;

{$R *.dfm}

procedure TStudentView.BitBtn1Click(Sender: TObject);
begin
  panel1.Visible:=true;             //----��ʾPanel1�����ϵ�����----
  panel2.Visible:=false;
  panel3.Visible:=false;
  button3.Click;    //-----�൱�ڴ���button3----
end;

procedure TStudentView.BitBtn2Click(Sender: TObject);
var
  i:integer;
begin
  panel1.Visible:=false;
  panel2.Visible:=true;  //��ʾPanel2
  panel3.Visible:=false;
  Stringgrid2.ColCount:=6;
  //----����Stringgrid���п�Ⱥ�����----
  Stringgrid2.ColWidths[0]:=65;
  Stringgrid2.ColWidths[1]:=105;
  Stringgrid2.ColWidths[2]:=105;
  Stringgrid2.ColWidths[3]:=250;
  Stringgrid2.ColWidths[4]:=160;
  Stringgrid2.ColWidths[5]:=100;
  stringgrid2.Cells[0,0]:='���';
  stringgrid2.Cells[1,0]:='�̹���';
  stringgrid2.Cells[2,0]:='����';
  stringgrid2.Cells[3,0]:='����';
  stringgrid2.Cells[4,0]:='�绰';
  stringgrid2.Cells[5,0]:='�ȼ�';
  button4.Click;  //----�൱�ڴ�����button4
end;

procedure TStudentView.BitBtn3Click(Sender: TObject);
begin
  panel3.Visible:=true;//��ʾpanel3
  panel2.Visible:=false;
  panel1.Visible:=false;
  //----����Stringgrid3���������п�---
  stringgrid3.Cells[0,0]:='���';
  stringgrid3.Cells[1,0]:='�γ̺�';
  stringgrid3.Cells[2,0]:='�γ���';
  stringgrid3.Cells[3,0]:='�̹���';
  stringgrid3.Cells[4,0]:='�γ�ʱ��';
  stringgrid3.Cells[5,0]:='���ұ��';
  stringgrid3.Cells[6,0]:='ѧ��';
  stringgrid3.Cells[7,0]:='ѧʱ';
  stringgrid3.ColWidths[0]:=50;
  stringgrid3.ColWidths[1]:=150;
  stringgrid3.ColWidths[2]:=150;
  stringgrid3.ColWidths[3]:=100;
  stringgrid3.ColWidths[4]:=100;
  stringgrid3.ColWidths[5]:=100;
  stringgrid3.ColWidths[6]:=65;
  stringgrid3.ColWidths[7]:=65;
  button5.Click;  //----�൱�ڴ�����button5
end;

procedure TStudentView.Button1Click(Sender: TObject);
var
  temp:string;
begin
  button2.Visible:=false;
  if (Combobox2.Text='') or (combobox3.Text='') then   //----ʱ��β���Ϊ��-----
    showmessage('����������ʱ���')
  else
  begin
    stringgrid1.ColCount:=5;
    //-------����������ÿ�еĿ��-------
    stringgrid1.Cells[0,0]:='���';
    stringgrid1.Cells[1,0]:='���ұ��';
    stringgrid1.Cells[2,0]:='����';
    stringgrid1.Cells[3,0]:='����';
    stringgrid1.Cells[4,0]:='����';
    stringgrid1.ColWidths[0]:=40;
    stringgrid1.ColWidths[1]:=90;
    stringgrid1.ColWidths[2]:=165;
    stringgrid1.ColWidths[3]:=50;
    stringgrid1.ColWidths[4]:=165;
    temp:=Combobox2.Text+combobox3.Text;
    //------���в���------
    adoquery1.Close;
    adoquery1.SQL.Clear;
    adoquery1.SQL.Add('select * from classroom as CR where CR.��� not in (select classroom.��� from classroom ,stu_classroom where  stu_classroom.����ʱ��='''+temp+''' and stu_classroom.���ұ��=classroom.���) ');
    adoquery1.SQL.Add('and CR.��� not in (select classroom.��� from classroom ,tea_classroom where  tea_classroom.����ʱ��='''+temp+''' and tea_classroom.���ұ��=classroom.���) ');
    adoquery1.SQL.Add('and CR.��� not in (select classroom.��� from classroom ,course where  course.ʱ��='''+temp+''' and course.���ұ��=classroom.���) ');
    if (combobox1.text<>'') and (combobox1.Text<>' ') then
      adoquery1.SQL.Add('and CR.����='''+combobox1.text+''' ');
    if (edit1.Text<>'') and (edit1.Text<>' ') then
      adoquery1.SQL.Add('and CR.����>='+edit1.text+' ');
    if (edit2.Text<>'') and (edit2.Text<>' ') then
      adoquery1.SQL.Add('and CR.����<='+edit2.text+' ');
    if (edit3.Text<>'') and (edit3.Text<>' ') then
      adoquery1.SQL.Add('and CR.��� like '''+'%'+edit3.Text+'%'+''' ');
    adoquery1.Open;
    stringgrid1.RowCount:=1;      //----��������---
    while not adoquery1.Eof do      //----��Stringgrid �м�������---
    begin
      Stringgrid1.Cells[0,Stringgrid1.RowCount]:=inttostr(Stringgrid1.RowCount);
      Stringgrid1.Cells[1,Stringgrid1.RowCount]:=adoquery1.FieldByName('���').AsString;
      Stringgrid1.Cells[2,Stringgrid1.RowCount]:=adoquery1.FieldByName('����').AsString;
      Stringgrid1.Cells[3,Stringgrid1.RowCount]:=adoquery1.FieldByName('����').AsString;
      Stringgrid1.Cells[4,Stringgrid1.RowCount]:=adoquery1.FieldByName('����').AsString;
      Stringgrid1.RowCount:=Stringgrid1.RowCount+1;     //----�޸�����----
      adoquery1.Next;
    end;
  end;
end;


procedure TStudentView.Button2Click(Sender: TObject);
var
  temp:string;        //---�������,�����¼��stu_classroom��
begin
  temp:=combobox2.Text+combobox3.Text;
  adocommand1.CommandText:='insert into stu_classroom values('''+statusbar1.Panels[2].Text+''','''+stringgrid1.Cells[1,CurrentRow]+''','''+temp+''')';
  adocommand1.Execute;
  //-----����Stringgrid�е�����----
  adoquery1.Close;
  adoquery1.SQL.Clear;
  adoquery1.SQL.Add('select * from classroom as CR where CR.��� not in (select classroom.��� from classroom ,stu_classroom where  stu_classroom.����ʱ��='''+temp+''' and stu_classroom.���ұ��=classroom.���) ');
  adoquery1.SQL.Add('and CR.��� not in (select classroom.��� from classroom ,tea_classroom where  tea_classroom.����ʱ��='''+temp+''' and tea_classroom.���ұ��=classroom.���) ');
  adoquery1.SQL.Add('and CR.��� not in (select classroom.��� from classroom ,course where  course.ʱ��='''+temp+''' and course.���ұ��=classroom.���) ');
  if (combobox1.text<>'') and (combobox1.Text<>' ') then
    adoquery1.SQL.Add('and CR.����='''+combobox1.text+''' ');
  if (edit1.Text<>'') and (edit1.Text<>' ') then
    adoquery1.SQL.Add('and CR.����>='+edit1.text+' ');
  if (edit2.Text<>'') and (edit2.Text<>' ') then
    adoquery1.SQL.Add('and CR.����<='+edit2.text+' ');
  if (edit3.Text<>'') and (edit3.Text<>' ') then
    adoquery1.SQL.Add('and CR.��� like '''+'%'+edit3.Text+'%'+''' ');
  adoquery1.Open;
  stringgrid1.RowCount:=1;      //----��������---
  while not adoquery1.Eof do      //----��Stringgrid �м�������---
  begin
    Stringgrid1.Cells[0,Stringgrid1.RowCount]:=inttostr(Stringgrid1.RowCount);
    Stringgrid1.Cells[1,Stringgrid1.RowCount]:=adoquery1.FieldByName('���').AsString;
    Stringgrid1.Cells[2,Stringgrid1.RowCount]:=adoquery1.FieldByName('����').AsString;
    Stringgrid1.Cells[3,Stringgrid1.RowCount]:=adoquery1.FieldByName('����').AsString;
    Stringgrid1.Cells[4,Stringgrid1.RowCount]:=adoquery1.FieldByName('����').AsString;
    Stringgrid1.RowCount:=Stringgrid1.RowCount+1;     //----�޸�����----
    adoquery1.Next;
  end;
  showmessage('����ɹ�');  //----��ʾ����ɹ�----
end;

procedure TStudentView.Button3Click(Sender: TObject);
var
  temp:string;
  i:integer;
begin
  //------����������ÿ�еĿ��--------
  temp:=combobox2.Text+combobox3.Text;
  stringgrid1.ColCount:=6;
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
  adoquery1.Close;               //-----��ѯ������ѧ�����ý��ҵ���Ϣ-------
  adoquery1.SQL.Clear;
  if (combobox2.Text<>'') or (combobox3.Text<>'')  then
    adoquery1.SQL.Add('(select ���,����,ѧ��,����ʱ�� from classroom ,stu_classroom where  stu_classroom.����ʱ�� like'''+'%'+temp+'%'+''' and stu_classroom.���ұ��=classroom.���) ')
    else
    adoquery1.SQL.Add('(select ���,����,ѧ��,����ʱ�� from classroom ,stu_classroom where classroom.���=stu_classroom.���ұ��)');
  if (combobox1.text<>'') and (combobox1.Text<>' ') then
    adoquery1.SQL.Add('intersect (select ���,����,ѧ��,����ʱ�� from classroom ,stu_classroom where classroom.����='''+combobox1.text+'''and stu_classroom.���ұ��=classroom.���) ');
  if (edit1.Text<>'') and (edit1.Text<>' ') then
    adoquery1.SQL.Add('intersect (select ���,����,ѧ��,����ʱ�� from classroom ,stu_classroom where classroom.����>='+edit1.text+'and stu_classroom.���ұ��=classroom.���) ');
  if (edit2.Text<>'') and (edit2.Text<>' ') then
    adoquery1.SQL.Add('intersect (select ���,����,ѧ��,����ʱ�� from classroom ,stu_classroom where classroom.����<='+edit2.text+'and stu_classroom.���ұ��=classroom.���) ');
  if (edit3.Text<>'') and (edit3.Text<>' ') then
    adoquery1.SQL.Add('intersect (select ���,����,ѧ��,����ʱ�� from classroom ,stu_classroom where stu_classroom.���ұ��=classroom.��� and classroom.��� like '''+'%'+edit3.Text+'%'+''')');
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
    adoquery1.SQL.Add('intersect (select ���,����,�̹���,����ʱ�� from classroom ,tea_classroom where classroom.����='''+combobox1.text+'''and tea_classroom.���ұ��=classroom.���) ');
  if (edit1.Text<>'') and (edit1.Text<>' ') then
    adoquery1.SQL.Add('intersect (select ���,����,�̹���,����ʱ�� from classroom ,tea_classroom where classroom.����>='+edit1.text+'and tea_classroom.���ұ��=classroom.���) ');
  if (edit2.Text<>'') and (edit2.Text<>' ') then
    adoquery1.SQL.Add('intersect (select ���,����,�̹���,����ʱ�� from classroom ,tea_classroom where classroom.����<='+edit2.text+'and tea_classroom.���ұ��=classroom.���) ');
  if (edit3.Text<>'') and (edit3.Text<>' ') then
    adoquery1.SQL.Add('intersect(select ���,����,�̹���,����ʱ�� from classroom ,tea_classroom where tea_classroom.���ұ��=classroom.��� and classroom.��� like '''+'%'+edit3.Text+'%'+''')');
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
    adoquery1.SQL.Add('(select  ���,����,�γ̺�,ʱ�� from classroom ,course where  course.ʱ�� like'''+'%'+temp+'%'+'''  and course.���ұ��=classroom.���) ')
  else
    adoquery1.SQL.Add('(select  ���,����,�γ̺�,ʱ�� from classroom ,course where classroom.���=course.���ұ��)');
  if (combobox1.text<>'') and (combobox1.Text<>' ') then
    adoquery1.SQL.Add('intersect (select  ���,����,�γ̺�,ʱ�� from classroom ,course where classroom.����='''+combobox1.text+'''and course.���ұ��=classroom.���) ');
  if (edit1.Text<>'') and (edit1.Text<>' ') then
    adoquery1.SQL.Add('intersect (select  ���,����,�γ̺�,ʱ�� from classroom ,course where classroom.����>='+edit1.text+'and course.���ұ��=classroom.���) ');
  if (edit2.Text<>'') and (edit2.Text<>' ') then
    adoquery1.SQL.Add('intersect (select  ���,����,�γ̺�,ʱ�� from classroom ,course where classroom.����<='+edit2.text+'and course.���ұ��=classroom.���) ');
  if (edit3.Text<>'') and (edit3.Text<>' ') then
    adoquery1.SQL.Add('intersect (select  ���,����,�γ̺�,ʱ�� from classroom ,course where course.���ұ��=classroom.��� and classroom.��� like '''+'%'+edit3.Text+'%'+''')');
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

procedure TStudentView.Button4Click(Sender: TObject);  //----��ѯ��ʦ��Ϣ�еĲ�ѯ��ť---
var
  i:integer;
begin
  if (edit4.Text='') and (edit5.Text='') then
  begin
    adoquery1.Close;
    adoquery1.SQL.Clear;
    adoquery1.SQL.Add('select * from teacher');
    i:=1;
    adoquery1.Open;
    while not adoquery1.Eof do
    begin
      Stringgrid2.Cells[0,i]:=inttostr(i);
      stringgrid2.Cells[1,i]:=adoquery1.FieldByName('�̹���').AsString;
      stringgrid2.Cells[2,i]:=adoquery1.FieldByName('����').AsString;
      stringgrid2.Cells[3,i]:=adoquery1.FieldByName('����').AsString;
      stringgrid2.Cells[4,i]:=adoquery1.FieldByName('�绰').AsString;
      stringgrid2.Cells[5,i]:=adoquery1.FieldByName('�ȼ�').AsString;
      i:=i+1;
      adoquery1.Next;
    end;
    stringgrid2.RowCount:=i;
  end
  else
  begin
    adoquery1.Close;
    adoquery1.SQL.Clear;
    if edit4.Text<>'' then
      adoquery1.SQL.Add('(select * from teacher where teacher.�̹��� like '''+'%'+edit4.text+'%'+''')')
    else
      adoquery1.SQL.Add('(select * from teacher where teacher.���� like '''+'%'+edit5.text+'%'+''')');
    if edit5.Text<>'' then
      adoquery1.SQL.Add('intersect (select * from teacher where teacher.���� like '''+'%'+edit5.text+'%'+''')');
    adoquery1.Open;
    i:=1;
    while not adoquery1.Eof do
    begin
      Stringgrid2.Cells[0,i]:=inttostr(i);
      stringgrid2.Cells[1,i]:=adoquery1.FieldByName('�̹���').AsString;
      stringgrid2.Cells[2,i]:=adoquery1.FieldByName('����').AsString;
      stringgrid2.Cells[3,i]:=adoquery1.FieldByName('����').AsString;
      stringgrid2.Cells[4,i]:=adoquery1.FieldByName('�绰').AsString;
      stringgrid2.Cells[5,i]:=adoquery1.FieldByName('�ȼ�').AsString;
      i:=i+1;
      adoquery1.Next;
    end;
    stringgrid2.RowCount:=i;

  end;
end;

procedure TStudentView.Button5Click(Sender: TObject);
var
  i:integer;
begin
  adoquery1.Close;
  adoquery1.SQL.Clear;
  //-----�������пγ̵���Ϣ----
  adoquery1.sql.add('(select  �γ̺�,�γ���,�̹���,ʱ��,���ұ��,ѧ��,ѧʱ from course)');
  if edit6.Text<>'' then
  //--������ҿγ̺ŵ���Ϣ---
    adoquery1.sql.add('intersect (select �γ̺�,�γ���,�̹���,ʱ��,���ұ��,ѧ��,ѧʱ from course where �γ̺� like '''+'%'+edit6.Text+'%'+''')');
  if edit7.Text<>'' then
    adoquery1.sql.add('intersect (select �γ̺�,�γ���,�̹���,ʱ��,���ұ��,ѧ��,ѧʱ from course where �γ��� like '''+'%'+edit7.Text+'%'+''')');
  if edit8.Text<>'' then
    adoquery1.sql.add('intersect (select �γ̺�,�γ���,�̹���,ʱ��,���ұ��,ѧ��,ѧʱ from course where �̹��� like '''+'%'+edit8.Text+'%'+''')');
  if (combobox4.text<>'')  or (combobox5.Text<>'') then
    adoquery1.sql.add('intersect (select �γ̺�,�γ���,�̹���,ʱ��,���ұ��,ѧ��,ѧʱ from course where ʱ�� like '''+'%'+combobox4.Text+combobox5.text+'%'+''')');
  adoquery1.Open;
  i:=1;
  while not adoquery1.Eof do      //-----�����ѯ���------
  begin
    stringgrid3.Cells[0,i]:=inttostr(i);
    stringgrid3.Cells[1,i]:=adoquery1.FieldByName('�γ̺�').AsString;
    stringgrid3.Cells[2,i]:=adoquery1.FieldByName('�γ���').AsString;
    stringgrid3.Cells[3,i]:=adoquery1.FieldByName('�̹���').AsString;
    stringgrid3.Cells[4,i]:=adoquery1.FieldByName('ʱ��').AsString;
    stringgrid3.Cells[5,i]:=adoquery1.FieldByName('���ұ��').AsString;
    stringgrid3.Cells[6,i]:=adoquery1.FieldByName('ѧ��').AsString;
    stringgrid3.Cells[7,i]:=adoquery1.FieldByName('ѧʱ').AsString;
    i:=i+1;
    adoquery1.Next;
  end;
  stringgrid3.rowCount:=i;
end;

procedure TStudentView.ComboBox2Change(Sender: TObject);
begin
  if (combobox2.Text<>'') and (combobox3.Text<>'') then
    button1.Click;         //----����Stringgrid�е�����----
  button2.Visible:=false;    //���ʱ�θı� ������button���ɼ�

end;

procedure TStudentView.ComboBox3Change(Sender: TObject);
begin
  if (combobox2.Text<>'') and (combobox3.Text<>'') then
    button1.Click;
  button2.Visible:=false;
end;

procedure TStudentView.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  login.close;   //�ر���������
end;

procedure TStudentView.FormShow(Sender: TObject);
begin
  bitbtn1.Click;  //����bitbtn1
end;

procedure TStudentView.StringGrid1SelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);    //----ѡ��ĳһ�� ����ʾ���밴ť---
var
  temp:string;
begin
  currentRow:=Arow;
  if (stringgrid1.ColCount=5) and (Arow<>0) then                        //----������ǵ�һ�� ����ʾ���밴ť  ---
    button2.Visible:=true
  else
    button2.Visible:=false;

end;

end.
