unit FormTeacher;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ADODB, DB, StdCtrls, Grids, ExtCtrls, Buttons, ComCtrls, jpeg;

type
  TTeacherView = class(TForm)
    Image1: TImage;
    StatusBar1: TStatusBar;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    Panel1: TPanel;
    StringGrid1: TStringGrid;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    ComboBox3: TComboBox;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    ADOQuery1: TADOQuery;
    ADOCommand1: TADOCommand;
    Panel2: TPanel;
    StringGrid2: TStringGrid;
    Label6: TLabel;
    Label7: TLabel;
    Edit4: TEdit;
    Edit5: TEdit;
    Button4: TButton;
    Label8: TLabel;
    Edit6: TEdit;
    Label9: TLabel;
    Edit7: TEdit;
    Panel3: TPanel;
    StringGrid3: TStringGrid;
    Label10: TLabel;
    Edit8: TEdit;
    Label11: TLabel;
    Edit9: TEdit;
    Label12: TLabel;
    ComboBox4: TComboBox;
    ComboBox5: TComboBox;
    Label13: TLabel;
    Edit10: TEdit;
    Button5: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure ComboBox3Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  TeacherView: TTeacherView;
  CurrentRow:integer;

implementation

uses FormLogin;

{$R *.dfm}

procedure TTeacherView.BitBtn1Click(Sender: TObject);
begin
  panel1.Visible:=true;             //----显示Panel1及其上的内容----
  panel2.Visible:=false;
  panel3.Visible:=false;
  button3.Click;    //-----相当于触发button3----
end;

procedure TTeacherView.BitBtn2Click(Sender: TObject);
var
  i:integer;
begin
  panel1.Visible:=false;
  panel2.Visible:=true;  //显示Panel2
  panel3.Visible:=false;
  Stringgrid2.ColCount:=5;
  //----设置Stringgrid的列宽度和列名----
  Stringgrid2.ColWidths[0]:=60;
  Stringgrid2.ColWidths[1]:=150;
  Stringgrid2.ColWidths[2]:=100;
  Stringgrid2.ColWidths[3]:=110;
  Stringgrid2.ColWidths[4]:=110;
  stringgrid2.Cells[0,0]:='序号';
  stringgrid2.Cells[1,0]:='学号';
  stringgrid2.Cells[2,0]:='姓名';
  stringgrid2.Cells[3,0]:='班级';
  stringgrid2.Cells[4,0]:='学院';
  button4.Click;  //----相当于触发了button4
end;

procedure TTeacherView.BitBtn3Click(Sender: TObject);
begin
  panel3.Visible:=true;   //----显示panel3----
  panel1.Visible:=false;
  panel2.Visible:=false;
  //----设置Stringgrid3的列名和列宽---
  stringgrid3.Cells[0,0]:='序号';
  stringgrid3.Cells[1,0]:='课程号';
  stringgrid3.Cells[2,0]:='课程名';
  stringgrid3.Cells[3,0]:='教工号';
  stringgrid3.Cells[4,0]:='课程时段';
  stringgrid3.Cells[5,0]:='教室编号';
  stringgrid3.Cells[6,0]:='学分';
  stringgrid3.Cells[7,0]:='学时';
  stringgrid3.ColWidths[0]:=50;
  stringgrid3.ColWidths[1]:=150;
  stringgrid3.ColWidths[2]:=150;
  stringgrid3.ColWidths[3]:=100;
  stringgrid3.ColWidths[4]:=100;
  stringgrid3.ColWidths[5]:=100;
  stringgrid3.ColWidths[6]:=65;
  stringgrid3.ColWidths[7]:=65;
  button5.Click;
end;

procedure TTeacherView.Button1Click(Sender: TObject);
var
  temp:string;
begin
  button2.Visible:=false;
  if (Combobox2.Text='') or (combobox3.Text='') then   //----时间段不能为空-----
    showmessage('请输入完整时间段')
  else
  begin
    stringgrid1.ColCount:=5;
    //-------设置列名和每列的宽度-------
    stringgrid1.Cells[0,0]:='序号';
    stringgrid1.Cells[1,0]:='教室编号';
    stringgrid1.Cells[2,0]:='名称';
    stringgrid1.Cells[3,0]:='容量';
    stringgrid1.Cells[4,0]:='类型';
    stringgrid1.ColWidths[0]:=40;
    stringgrid1.ColWidths[1]:=90;
    stringgrid1.ColWidths[2]:=165;
    stringgrid1.ColWidths[3]:=50;
    stringgrid1.ColWidths[4]:=165;
    temp:=Combobox2.Text+combobox3.Text;
    //------进行查找------
    adoquery1.Close;
    adoquery1.SQL.Clear;
    adoquery1.SQL.Add('select * from classroom as CR where CR.编号 not in (select classroom.编号 from classroom ,stu_classroom where  stu_classroom.借用时段='''+temp+''' and stu_classroom.教室编号=classroom.编号) ');
    adoquery1.SQL.Add('and CR.编号 not in (select classroom.编号 from classroom ,tea_classroom where  tea_classroom.借用时段='''+temp+''' and tea_classroom.教室编号=classroom.编号) ');
    adoquery1.SQL.Add('and CR.编号 not in (select classroom.编号 from classroom ,course where  course.时段='''+temp+''' and course.教室编号=classroom.编号) ');
    if (combobox1.text<>'') and (combobox1.Text<>' ') then
      adoquery1.SQL.Add('and CR.类型='''+combobox1.text+''' ');
    if (edit1.Text<>'') and (edit1.Text<>' ') then
      adoquery1.SQL.Add('and CR.容量>='+edit1.text+' ');
    if (edit2.Text<>'') and (edit2.Text<>' ') then
      adoquery1.SQL.Add('and CR.容量<='+edit2.text+' ');
    if (edit3.Text<>'') and (edit3.Text<>' ') then
      adoquery1.SQL.Add('and CR.编号 like '''+'%'+edit3.Text+'%'+''' ');
    adoquery1.Open;
    stringgrid1.RowCount:=1;      //----设置行数---
    while not adoquery1.Eof do      //----向Stringgrid 中加入数据---
    begin
      Stringgrid1.Cells[0,Stringgrid1.RowCount]:=inttostr(Stringgrid1.RowCount);
      Stringgrid1.Cells[1,Stringgrid1.RowCount]:=adoquery1.FieldByName('编号').AsString;
      Stringgrid1.Cells[2,Stringgrid1.RowCount]:=adoquery1.FieldByName('名称').AsString;
      Stringgrid1.Cells[3,Stringgrid1.RowCount]:=adoquery1.FieldByName('容量').AsString;
      Stringgrid1.Cells[4,Stringgrid1.RowCount]:=adoquery1.FieldByName('类型').AsString;
      Stringgrid1.RowCount:=Stringgrid1.RowCount+1;     //----修改行数----
      adoquery1.Next;
    end;
  end;
end;

procedure TTeacherView.Button2Click(Sender: TObject);
var
  temp:string;        //---提出申请,插入记录到tea_classroom中
begin
  temp:=combobox2.Text+combobox3.Text;
  adocommand1.CommandText:='insert into tea_classroom values('''+statusbar1.Panels[2].Text+''','''+stringgrid1.Cells[1,CurrentRow]+''','''+temp+''')';
  adocommand1.Execute;
  //-----更新Stringgrid中的内容----
  adoquery1.Close;
  adoquery1.SQL.Clear;
  adoquery1.SQL.Add('select * from classroom as CR where CR.编号 not in (select classroom.编号 from classroom ,stu_classroom where  stu_classroom.借用时段='''+temp+''' and stu_classroom.教室编号=classroom.编号) ');
  adoquery1.SQL.Add('and CR.编号 not in (select classroom.编号 from classroom ,tea_classroom where  tea_classroom.借用时段='''+temp+''' and tea_classroom.教室编号=classroom.编号) ');
  adoquery1.SQL.Add('and CR.编号 not in (select classroom.编号 from classroom ,course where  course.时段='''+temp+''' and course.教室编号=classroom.编号) ');
  if (combobox1.text<>'') and (combobox1.Text<>' ') then
    adoquery1.SQL.Add('and CR.类型='''+combobox1.text+''' ');
  if (edit1.Text<>'') and (edit1.Text<>' ') then
    adoquery1.SQL.Add('and CR.容量>='+edit1.text+' ');
  if (edit2.Text<>'') and (edit2.Text<>' ') then
    adoquery1.SQL.Add('and CR.容量<='+edit2.text+' ');
  if (edit3.Text<>'') and (edit3.Text<>' ') then
    adoquery1.SQL.Add('and CR.编号 like '''+'%'+edit3.Text+'%'+''' ');
  adoquery1.Open;
  stringgrid1.RowCount:=1;      //----设置行数---
  while not adoquery1.Eof do      //----向Stringgrid 中加入数据---
  begin
    Stringgrid1.Cells[0,Stringgrid1.RowCount]:=inttostr(Stringgrid1.RowCount);
    Stringgrid1.Cells[1,Stringgrid1.RowCount]:=adoquery1.FieldByName('编号').AsString;
    Stringgrid1.Cells[2,Stringgrid1.RowCount]:=adoquery1.FieldByName('名称').AsString;
    Stringgrid1.Cells[3,Stringgrid1.RowCount]:=adoquery1.FieldByName('容量').AsString;
    Stringgrid1.Cells[4,Stringgrid1.RowCount]:=adoquery1.FieldByName('类型').AsString;
    Stringgrid1.RowCount:=Stringgrid1.RowCount+1;     //----修改行数----
    adoquery1.Next;
  end;
  showmessage('申请成功');  //----提示申请成功----
end;

procedure TTeacherView.Button3Click(Sender: TObject);
var
  temp:string;
  i:integer;
begin
  //------设置列名和每列的宽度--------
  temp:=combobox2.Text+combobox3.Text;
  stringgrid1.ColCount:=6;
  stringgrid1.Cells[0,0]:='序号';
  stringgrid1.Cells[1,0]:='教室编号';
  stringgrid1.Cells[2,0]:='教室名称';
  stringgrid1.Cells[3,0]:='使用对象';
  stringgrid1.Cells[4,0]:='对象编号';
  stringgrid1.Cells[5,0]:='使用时段';
  stringgrid1.ColWidths[0]:=40;
  stringgrid1.ColWidths[1]:=80;
  stringgrid1.ColWidths[2]:=110;
  stringgrid1.ColWidths[3]:=75;
  stringgrid1.ColWidths[4]:=115;
  stringgrid1.ColWidths[5]:=85;
  adoquery1.Close;               //-----查询并加入学生借用教室的信息-------
  adoquery1.SQL.Clear;
  if (combobox2.Text<>'') or (combobox3.Text<>'')  then
    adoquery1.SQL.Add('(select 编号,名称,学号,借用时段 from classroom ,stu_classroom where  stu_classroom.借用时段 like'''+'%'+temp+'%'+''' and stu_classroom.教室编号=classroom.编号) ')
    else
    adoquery1.SQL.Add('(select 编号,名称,学号,借用时段 from classroom ,stu_classroom where classroom.编号=stu_classroom.教室编号)');
  if (combobox1.text<>'') and (combobox1.Text<>' ') then
    adoquery1.SQL.Add('intersect (select 编号,名称,学号,借用时段 from classroom ,stu_classroom where classroom.类型='''+combobox1.text+'''and stu_classroom.教室编号=classroom.编号) ');
  if (edit1.Text<>'') and (edit1.Text<>' ') then
    adoquery1.SQL.Add('intersect (select 编号,名称,学号,借用时段 from classroom ,stu_classroom where classroom.容量>='+edit1.text+'and stu_classroom.教室编号=classroom.编号) ');
  if (edit2.Text<>'') and (edit2.Text<>' ') then
    adoquery1.SQL.Add('intersect (select 编号,名称,学号,借用时段 from classroom ,stu_classroom where classroom.容量<='+edit2.text+'and stu_classroom.教室编号=classroom.编号) ');
  if (edit3.Text<>'') and (edit3.Text<>' ') then
    adoquery1.SQL.Add('intersect (select 编号,名称,学号,借用时段 from classroom ,stu_classroom where stu_classroom.教室编号=classroom.编号 and classroom.编号 like '''+'%'+edit3.Text+'%'+''')');
  adoquery1.Open;
  i:=1;
  while not adoquery1.Eof do
  begin
    stringgrid1.Cells[0,i]:=inttostr(i);
    stringgrid1.Cells[1,i]:=adoquery1.FieldByName('编号').AsString;
    stringgrid1.Cells[2,i]:=adoquery1.FieldByName('名称').AsString;
    stringgrid1.Cells[3,i]:='学生';
    stringgrid1.Cells[4,i]:=adoquery1.FieldByName('学号').AsString;
    stringgrid1.Cells[5,i]:=adoquery1.FieldByName('借用时段').AsString;
    i:=i+1;
    adoquery1.Next;
  end;
  adoquery1.Close;                //-----查询并加入教师借用教室的信息-------
  adoquery1.SQL.Clear;
  if (combobox2.Text<>'') or (combobox3.Text<>'')  then
    adoquery1.SQL.Add('(select 编号,名称,教工号,借用时段 from classroom ,tea_classroom where  tea_classroom.借用时段  like'''+'%'+temp+'%'+''' and tea_classroom.教室编号=classroom.编号) ')
  else
    adoquery1.SQL.Add('(select 编号,名称,教工号,借用时段 from classroom ,tea_classroom where classroom.编号=tea_classroom.教室编号)');
  if (combobox1.text<>'') and (combobox1.Text<>' ') then
    adoquery1.SQL.Add('intersect (select 编号,名称,教工号,借用时段 from classroom ,tea_classroom where classroom.类型='''+combobox1.text+'''and tea_classroom.教室编号=classroom.编号) ');
  if (edit1.Text<>'') and (edit1.Text<>' ') then
    adoquery1.SQL.Add('intersect (select 编号,名称,教工号,借用时段 from classroom ,tea_classroom where classroom.容量>='+edit1.text+'and tea_classroom.教室编号=classroom.编号) ');
  if (edit2.Text<>'') and (edit2.Text<>' ') then
    adoquery1.SQL.Add('intersect (select 编号,名称,教工号,借用时段 from classroom ,tea_classroom where classroom.容量<='+edit2.text+'and tea_classroom.教室编号=classroom.编号) ');
  if (edit3.Text<>'') and (edit3.Text<>' ') then
    adoquery1.SQL.Add('intersect(select 编号,名称,教工号,借用时段 from classroom ,tea_classroom where tea_classroom.教室编号=classroom.编号 and classroom.编号 like '''+'%'+edit3.Text+'%'+''')');
  adoquery1.Open;
  while not adoquery1.Eof do
  begin
    stringgrid1.Cells[0,i]:=inttostr(i);
    stringgrid1.Cells[1,i]:=adoquery1.FieldByName('编号').AsString;
    stringgrid1.Cells[2,i]:=adoquery1.FieldByName('名称').AsString;
    stringgrid1.Cells[3,i]:='教师';
    stringgrid1.Cells[4,i]:=adoquery1.FieldByName('教工号').AsString;
    stringgrid1.Cells[5,i]:=adoquery1.FieldByName('借用时段').AsString;
    i:=i+1;
    adoquery1.Next;
  end;
  adoquery1.Close;                  //-----查询并加入课程占用教室的信息-------
  adoquery1.SQL.Clear;
  if (combobox2.Text<>'') or (combobox3.Text<>'') then
    adoquery1.SQL.Add('(select  编号,名称,课程号,时段 from classroom ,course where  时段 like'''+'%'+temp+'%'+'''  and 教室编号=编号) ')
  else
    adoquery1.SQL.Add('(select  编号,名称,课程号,时段 from classroom ,course where  编号=教室编号)');
  if (combobox1.text<>'') and (combobox1.Text<>' ') then
    adoquery1.SQL.Add('intersect (select  编号,名称,课程号,时段 from classroom ,course where 类型='''+combobox1.text+'''and 教室编号=编号) ');
  if (edit1.Text<>'') and (edit1.Text<>' ') then
    adoquery1.SQL.Add('intersect (select  编号,名称,课程号,时段 from classroom ,course where 容量>='+edit1.text+'and 教室编号=编号) ');
  if (edit2.Text<>'') and (edit2.Text<>' ') then
    adoquery1.SQL.Add('intersect (select  编号,名称,课程号,时段 from classroom ,course where 容量<='+edit2.text+'and 教室编号=编号) ');
  if (edit3.Text<>'') and (edit3.Text<>' ') then
    adoquery1.SQL.Add('intersect (select  编号,名称,课程号,时段 from classroom ,course where 教室编号=编号 and 编号 like '''+'%'+edit3.Text+'%'+''')');
  adoquery1.Open;
  while not adoquery1.Eof do
  begin
    stringgrid1.Cells[0,i]:=inttostr(i);
    stringgrid1.Cells[1,i]:=adoquery1.FieldByName('编号').AsString;
    stringgrid1.Cells[2,i]:=adoquery1.FieldByName('名称').AsString;
    stringgrid1.Cells[3,i]:='课程';
    stringgrid1.Cells[4,i]:=adoquery1.FieldByName('课程号').AsString;
    stringgrid1.Cells[5,i]:=adoquery1.FieldByName('时段').AsString;
    i:=i+1;
    adoquery1.Next;
  end;
  stringgrid1.RowCount:=i;  //---令stringgrid行数设置为i

end;

procedure TTeacherView.Button4Click(Sender: TObject);     //----查询学生信息------
var
  i:integer;
begin
  if (edit4.Text='') and (edit5.Text='') and (edit6.Text='') and (edit7.Text='') then
  begin
    adoquery1.Close;
    adoquery1.SQL.Clear;
    adoquery1.SQL.Add('select * from student');
    i:=1;
    adoquery1.Open;
    while not adoquery1.Eof do
    begin
      Stringgrid2.Cells[0,i]:=inttostr(i);
      stringgrid2.Cells[1,i]:=adoquery1.FieldByName('学号').AsString;
      stringgrid2.Cells[2,i]:=adoquery1.FieldByName('姓名').AsString;
      stringgrid2.Cells[3,i]:=adoquery1.FieldByName('班级').AsString;
      stringgrid2.Cells[4,i]:=adoquery1.FieldByName('学院').AsString;
      i:=i+1;
      adoquery1.Next;
    end;
    stringgrid2.RowCount:=i;
  end
  else
  begin
    adoquery1.Close;
    adoquery1.SQL.Clear;
    adoquery1.SQL.Add('(select * from student)');
    if edit4.Text<>'' then
      adoquery1.SQL.Add('intersect (select * from student where student.学号 like '''+'%'+edit4.text+'%'+''')');
    if edit5.Text<>'' then
      adoquery1.SQL.Add('intersect (select * from student where student.姓名 like '''+'%'+edit5.text+'%'+''')');
    if edit6.Text<>'' then
      adoquery1.SQL.Add('intersect (select * from student where student.班级 like '''+'%'+edit6.text+'%'+''')');
    if edit7.Text<>'' then
      adoquery1.SQL.Add('intersect (select * from student where student.学院 like '''+'%'+edit7.text+'%'+''')');
    adoquery1.Open;
    i:=1;
    while not adoquery1.Eof do
    begin
      Stringgrid2.Cells[0,i]:=inttostr(i);
      stringgrid2.Cells[1,i]:=adoquery1.FieldByName('学号').AsString;
      stringgrid2.Cells[2,i]:=adoquery1.FieldByName('姓名').AsString;
      stringgrid2.Cells[3,i]:=adoquery1.FieldByName('班级').AsString;
      stringgrid2.Cells[4,i]:=adoquery1.FieldByName('学院').AsString;
      i:=i+1;
      adoquery1.Next;
    end;
    stringgrid2.RowCount:=i;

  end;
end;

procedure TTeacherView.Button5Click(Sender: TObject);
var
  i:integer;
begin
  adoquery1.Close;
  adoquery1.SQL.Clear;
  //-----查找所有课程的信息----
  adoquery1.sql.add('(select  课程号,课程名,教工号,时段,教室编号,学分,学时 from course)');
  if edit8.Text<>'' then
  //--加入查找课程号的信息---
    adoquery1.sql.add('intersect (select 课程号,课程名,教工号,时段,教室编号,学分,学时 from course where 课程号 like '''+'%'+edit8.Text+'%'+''')');
  if edit9.Text<>'' then
    adoquery1.sql.add('intersect (select 课程号,课程名,教工号,时段,教室编号,学分,学时 from course where 课程名 like '''+'%'+edit9.Text+'%'+''')');
  if edit10.Text<>'' then
    adoquery1.sql.add('intersect (select 课程号,课程名,教工号,时段,教室编号,学分,学时 from course where 教工号 like '''+'%'+edit10.Text+'%'+''')');
  if (combobox4.text<>'')  or (combobox5.Text<>'') then
    adoquery1.sql.add('intersect (select 课程号,课程名,教工号,时段,教室编号,学分,学时 from course where 时段 like '''+'%'+combobox4.Text+combobox5.text+'%'+''')');
  adoquery1.Open;
  i:=1;
  while not adoquery1.Eof do      //-----加入查询结果------
  begin
    stringgrid3.Cells[0,i]:=inttostr(i);
    stringgrid3.Cells[1,i]:=adoquery1.FieldByName('课程号').AsString;
    stringgrid3.Cells[2,i]:=adoquery1.FieldByName('课程名').AsString;
    stringgrid3.Cells[3,i]:=adoquery1.FieldByName('教工号').AsString;
    stringgrid3.Cells[4,i]:=adoquery1.FieldByName('时段').AsString;
    stringgrid3.Cells[5,i]:=adoquery1.FieldByName('教室编号').AsString;
    stringgrid3.Cells[6,i]:=adoquery1.FieldByName('学分').AsString;
    stringgrid3.Cells[7,i]:=adoquery1.FieldByName('学时').AsString;
    i:=i+1;
    adoquery1.Next;
  end;
  stringgrid3.rowCount:=i;
end;

procedure TTeacherView.ComboBox2Change(Sender: TObject);
begin
  if (combobox2.Text<>'') and (combobox3.Text<>'') then   //----更新Stringgrid中的内容----
    button1.Click;
  button2.Visible:=false;    //如果时段改变 则设置button不可见
end;

procedure TTeacherView.ComboBox3Change(Sender: TObject);
begin
  if (combobox2.Text<>'') and (combobox3.Text<>'') then
    button1.Click;
  button2.Visible:=false;
end;

procedure TTeacherView.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  login.close;   //关闭整个程序
end;

procedure TTeacherView.FormShow(Sender: TObject);
begin
  bitbtn1.Click;  //触发bitbtn1
end;

procedure TTeacherView.StringGrid1SelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);//----选中某一行 ，显示申请按钮---
var
  temp:string;
begin
  currentRow:=Arow;
  if (stringgrid1.ColCount=5) and (Arow<>0) then                        //----如果不是第一行 则显示申请按钮  ---
    button2.Visible:=true
  else
    button2.Visible:=false;

end;

end.
