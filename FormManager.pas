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
  Currentrow:integer; //---定义CurrentRow为Stringgrid的当前行---
  currentrow2:integer;

implementation

uses FormLogin;

{$R *.dfm}
procedure TManagerView.Button10Click(Sender: TObject);
var
  i:integer;
begin
  button13.Visible:=false;//---令button13不可见---
  adoquery1.Close;
  adoquery1.SQL.Clear;
  //-----查找所有课程的信息----
  adoquery1.sql.add('(select 课程号,课程名,教工号,时段,教室编号,学分,学时 from course)');
  if edit8.Text<>'' then
  //--加入查找课程号的信息---
    adoquery1.sql.add('intersect (select  课程号,课程名,教工号,时段,教室编号,学分,学时 from course where 课程号 like '''+'%'+edit8.Text+'%'+''')');
  if edit9.Text<>'' then
    adoquery1.sql.add('intersect (select  课程号,课程名,教工号,时段,教室编号,学分,学时 from course where 课程名 like '''+'%'+edit9.Text+'%'+''')');
  if edit10.Text<>'' then
    adoquery1.sql.add('intersect (select  课程号,课程名,教工号,时段,教室编号,学分,学时 from course where 教工号 like '''+'%'+edit10.Text+'%'+''')');
  if (combobox5.text<>'')  or (combobox6.Text<>'') then
    adoquery1.sql.add('intersect (select  课程号,课程名,教工号,时段,教室编号,学分,学时 from course where 时段 like '''+'%'+combobox5.Text+combobox6.text+'%'+''')');
  adoquery1.Open;
  i:=1;
  while not adoquery1.Eof do      //-----加入查询结果------
  begin
    stringgrid2.Cells[0,i]:=inttostr(i);
    stringgrid2.Cells[1,i]:=adoquery1.FieldByName('课程号').AsString;
    stringgrid2.Cells[2,i]:=adoquery1.FieldByName('课程名').AsString;
    stringgrid2.Cells[3,i]:=adoquery1.FieldByName('教工号').AsString;
    stringgrid2.Cells[4,i]:=adoquery1.FieldByName('时段').AsString;
    stringgrid2.Cells[5,i]:=adoquery1.FieldByName('教室编号').AsString;
    stringgrid2.Cells[6,i]:=adoquery1.FieldByName('学分').AsString;
    stringgrid2.Cells[7,i]:=adoquery1.FieldByName('学时').AsString;
    i:=i+1;
    adoquery1.Next;
  end;
  stringgrid2.rowCount:=i;
end;

procedure TManagerView.Button11Click(Sender: TObject);
begin
  button13.Visible:=false;
  if (edit11.Text='') or (edit12.Text='') or (edit13.Text='') or (edit14.Text='') or (combobox7.Text='') or (combobox8.Text='')  or( edit15.Text='')or (edit16.Text='') or(edit17.Text='') then
    showmessage('请输入完整的课程信息')         //----提示输入完整的课程的信息----
  else
  begin
    adoquery1.close;
    adoquery1.SQL.Clear;
    adoquery1.SQL.Add('select * from course where 课程号='''+edit11.text+'''');
    adoquery1.Open;
    if adoquery1.FieldByName('课程号').AsString<>'' then
      showmessage('该课程已存在')              //-----提示课程已存在
    else
    begin
      adoquery1.close;
      adoquery1.SQL.Clear;
      adoquery1.SQL.Add('select * from teacher where 教工号='''+edit12.text+'''');
      adoquery1.Open;
      if adoquery1.FieldByName('教工号').AsString='' then
        showmessage('该教师不存在')              //-----提示教师不存在
      else
      begin
        adoquery1.close;
        adoquery1.SQL.Clear;
        adoquery1.SQL.Add('select * from classroom where 编号='''+edit14.text+'''');
        adoquery1.Open;
        if adoquery1.FieldByName('编号').AsString='' then
          showmessage('该教室不存在')              //-----提示教室不存在
        else
        begin
        //插入到course 中
        adocommand1.CommandText:='insert into course values('''+edit11.text+''','''+edit13.text+''','''+edit17.text+''','''+edit16.text+''','''+edit15.text+''','''+edit12.Text+''','''+edit14.Text+''','''+combobox7.Text+combobox8.Text+''')';
        adocommand1.Execute;
        showmessage('添加成功');
        edit8.Text:='';        //---清空内容----
        edit9.Text:='';
        edit10.Text:='';
        combobox5.Text:='';
        combobox6.Text:='';
        button10.Click; //触发button10
        end;
      end;
    end;

  end;

end;

procedure TManagerView.Button12Click(Sender: TObject);
begin
  button13.Visible:=false;
  if (edit11.Text='') or (edit12.Text='') or (edit13.Text='') or (edit14.Text='') or (combobox7.Text='') or (combobox8.Text='')  or( edit15.Text='')or (edit16.Text='') or(edit17.Text='') then
    showmessage('请输入完整的课程信息')         //----提示输入完整的课程的信息----
  else
  begin
    adoquery1.close;
    adoquery1.SQL.Clear;
    adoquery1.SQL.Add('select * from course where 课程号='''+edit11.text+'''');
    adoquery1.Open;
    if adoquery1.FieldByName('课程号').AsString='' then
      showmessage('该课程不存在')              //-----提示课程已存在
    else
    begin
      adoquery1.close;
      adoquery1.SQL.Clear;
      adoquery1.SQL.Add('select * from teacher where 教工号='''+edit12.text+'''');
      adoquery1.Open;
      if adoquery1.FieldByName('教工号').AsString='' then
        showmessage('该教师不存在')              //-----提示教师不存在
      else
      begin
        adoquery1.close;
        adoquery1.SQL.Clear;
        adoquery1.SQL.Add('select * from classroom where 编号='''+edit14.text+'''');
        adoquery1.Open;
        if adoquery1.FieldByName('编号').AsString='' then
          showmessage('该教室不存在')              //-----提示教室不存在
        else
        begin
        adocommand1.CommandText:='delete  from course where 课程号='''+edit11.text+'''';
        adocommand1.Execute;
        adocommand1.CommandText:='insert into course values('''+edit11.text+''','''+edit13.text+''','''+edit17.text+''','''+edit16.text+''','''+edit15.text+''','''+edit12.Text+''','''+edit14.Text+''','''+combobox7.Text+combobox8.Text+''')';
        adocommand1.Execute;
        showmessage('修改成功');
        edit8.Text:='';        //---清空内容----
        edit9.Text:='';
        edit10.Text:='';
        combobox5.Text:='';
        combobox6.Text:='';
        button10.Click; //触发button10
        end;
      end;
    end;
  end;
end;

procedure TManagerView.Button13Click(Sender: TObject);
begin             //删除课程信息
  adocommand1.CommandText:='delete from course where 课程号='''+stringgrid2.cells[1,currentrow]+'''';
  adocommand1.Execute;
  showmessage('删除成功');
  button10.Click;
end;

procedure TManagerView.Button14Click(Sender: TObject);   //---教师查询-----
begin
  button17.Visible:=false;
  stringgrid3.ColWidths[0]:=30;
  stringgrid3.ColWidths[1]:=75;
  stringgrid3.ColWidths[2]:=60;
  stringgrid3.ColWidths[3]:=80;
  stringgrid3.ColWidths[4]:=145;
  stringgrid3.ColWidths[5]:=60;
  stringgrid3.Cells[0,0]:='序号';
  stringgrid3.Cells[1,0]:='教工号';
  stringgrid3.Cells[2,0]:='姓名';
  stringgrid3.Cells[3,0]:='电话';
  stringgrid3.Cells[4,0]:='邮箱';
  stringgrid3.Cells[5,0]:='等级';
  adoquery1.Close;
  adoquery1.SQL.Clear;
  adoquery1.SQL.Add('(select * from teacher)');
  if edit18.Text<>'' then
    adoquery1.SQL.Add('intersect (select * from teacher where teacher.教工号 like '''+'%'+edit18.text+'%'+''')');
  if edit19.Text<>'' then
    adoquery1.SQL.Add('intersect (select * from teacher where teacher.姓名 like '''+'%'+edit19.text+'%'+''')');
  adoquery1.Open;
  stringgrid3.RowCount:=1;
  while not adoquery1.Eof do
  begin
    stringgrid3.Cells[0,stringgrid3.RowCount]:=inttostr(stringgrid3.RowCount);
    stringgrid3.Cells[1,stringgrid3.RowCount]:=adoquery1.FieldByName('教工号').Asstring;
    stringgrid3.Cells[2,stringgrid3.RowCount]:=adoquery1.FieldByName('姓名').AsString;
    stringgrid3.Cells[3,stringgrid3.RowCount]:=adoquery1.FieldByName('电话').AsString;
    stringgrid3.Cells[4,stringgrid3.RowCount]:=adoquery1.FieldByName('邮箱').AsString;
    stringgrid3.Cells[5,stringgrid3.RowCount]:=adoquery1.FieldByName('等级').AsString;
    stringgrid3.RowCount:=stringgrid3.RowCount+1;
    adoquery1.Next;
  end;
end;

procedure TManagerView.Button15Click(Sender: TObject);    //----添加教师信息---
begin
  if (edit18.Text='') or (edit19.text='') or (Combobox9.Text='') then
    showmessage('教工号，教师姓名，等级信息必须完整')      //-----提示输入信息必须完整的信息--
  else
  begin
    adoquery1.Close;
    adoquery1.SQL.Clear;
    adoquery1.SQL.Add('select * from teacher where 教工号='''+edit18.text+'''');
    adoquery1.Open;
    if adoquery1.FieldByName('教工号').AsString<>'' then
      showmessage('该教工号已存在') //----提示教工号已存在的信息----
    else
    begin                      //-----插入教师信息----
      //----设置初始密码为123
      adocommand1.CommandText:='insert into teacher values('''+edit18.Text+''','''+edit19.Text+''','''+edit22.Text+''','''+edit23.Text+''','''+combobox9.text+''',''123'')';
      adocommand1.Execute;
      showmessage('添加教师成功');
      button14.Click; //-----触发Button14-----
    end;
  end;
end;

procedure TManagerView.Button16Click(Sender: TObject);
begin
  if (edit18.Text='') or (edit19.text='') or (Combobox9.Text='') then
    showmessage('教工号，教师姓名，等级信息必须完整')      //-----提示输入信息必须完整的信息--
  else
  begin
    adoquery1.Close;
    adoquery1.SQL.Clear;
    adoquery1.SQL.Add('select * from teacher where 教工号='''+edit18.text+'''');
    adoquery1.Open;
    if adoquery1.FieldByName('教工号').AsString='' then
      showmessage('该教工号不存在') //----提示教工号不存在的信息----
    else
    begin                      //-----修改教师信息----
      adocommand1.CommandText:='update teacher set 姓名='''+edit19.Text+''' where 教工号='''+edit18.text+'''';
      adocommand1.Execute;
      adocommand1.CommandText:='update teacher set 电话='''+edit22.Text+''' where 教工号='''+edit18.text+'''';
      adocommand1.Execute;
      adocommand1.CommandText:='update teacher set 等级='''+combobox9.Text+''' where 教工号='''+edit18.text+'''';
      adocommand1.Execute;
      adocommand1.CommandText:='update teacher set 邮箱='''+edit23.Text+''' where 教工号='''+edit18.text+'''';
      adocommand1.Execute;
      showmessage('修改成功');
      button14.Click; //-----触发Button14-----
    end;
  end;
end;

procedure TManagerView.Button17Click(Sender: TObject);  //-----删除教师信息----
begin             //删除教师信息
  adocommand1.CommandText:='delete from teacher where 教工号='''+stringgrid3.cells[1,currentrow]+'''';
  adocommand1.Execute;
  adocommand1.CommandText:='update course set 教工号='''+''' where 教工号='''+stringgrid3.cells[1,currentrow]+'''';
  adocommand1.Execute;
  adocommand1.CommandText:='delete from tea_classroom where 教工号='''+stringgrid3.cells[1,currentrow]+'''';
  adocommand1.Execute;
  showmessage('删除成功');
  button14.Click;

end;

procedure TManagerView.Button18Click(Sender: TObject);
begin             //删除学生信息
  adocommand1.CommandText:='delete from student where 学号='''+stringgrid4.cells[1,currentrow2]+'''';
  adocommand1.Execute;
  adocommand1.CommandText:='delete from cou_student where 学号='''+stringgrid4.cells[1,currentrow2]+'''';
  adocommand1.Execute;
  adocommand1.CommandText:='delete from stu_classroom where 学号='''+stringgrid4.cells[1,currentrow2]+'''';
  adocommand1.Execute;
  showmessage('删除成功');
  button19.Click;
end;

procedure TManagerView.Button19Click(Sender: TObject);   //-----查询学生信息------
begin
  button18.Visible:=false;
  stringgrid4.ColWidths[0]:=40;
  stringgrid4.ColWidths[1]:=135;
  stringgrid4.ColWidths[2]:=80;
  stringgrid4.ColWidths[3]:=90;
  stringgrid4.ColWidths[4]:=100;
  stringgrid4.Cells[0,0]:='序号';
  stringgrid4.Cells[1,0]:='学号';
  stringgrid4.Cells[2,0]:='姓名';
  stringgrid4.Cells[3,0]:='班级';
  stringgrid4.Cells[4,0]:='学院';
  adoquery1.Close;
  adoquery1.SQL.Clear;
  adoquery1.SQL.Add('(select * from student)');
  if edit24.Text<>'' then
    adoquery1.SQL.Add('intersect (select * from student where 学号 like '''+'%'+edit24.text+'%'+''')');
  if edit25.Text<>'' then
    adoquery1.SQL.Add('intersect (select * from student where 姓名 like '''+'%'+edit25.text+'%'+''')');
  if edit26.Text<>'' then
    adoquery1.SQL.Add('intersect (select * from student where 班级 like '''+'%'+edit26.text+'%'+''')');
  if edit27.Text<>'' then
    adoquery1.SQL.Add('intersect (select * from student where 学院 like '''+'%'+edit27.text+'%'+''')');
  adoquery1.Open;
  stringgrid4.RowCount:=1;
  while not adoquery1.Eof do
  begin
    stringgrid4.Cells[0,stringgrid4.RowCount]:=inttostr(stringgrid4.RowCount);
    stringgrid4.Cells[1,stringgrid4.RowCount]:=adoquery1.FieldByName('学号').AsString;
    stringgrid4.Cells[2,stringgrid4.RowCount]:=adoquery1.FieldByName('姓名').AsString;
    stringgrid4.Cells[3,stringgrid4.RowCount]:=adoquery1.FieldByName('班级').AsString;
    stringgrid4.Cells[4,stringgrid4.RowCount]:=adoquery1.FieldByName('学院').AsString;
    stringgrid4.RowCount:=stringgrid4.RowCount+1;
    adoquery1.Next;
  end;
end;

procedure TManagerView.Button1Click(Sender: TObject);
begin
  panel1.Visible:=true;   //------使Panel1可见-----
  panel2.Visible:=false;
  panel3.Visible:=false;
  if stringgrid1.ColCount=5 then
    button4.Click  //触发教室查询
  else
    button5.Click;  //触发教室使用查询
end;

procedure TManagerView.Button20Click(Sender: TObject);       //----添加学生信息-----
begin
  if (edit24.Text='') or (edit25.text='') or (edit26.Text='') or(edit27.Text='') then
    showmessage('学生信息必须完整')      //-----提示输入信息必须完整的信息--
  else
  begin
    adoquery1.Close;
    adoquery1.SQL.Clear;
    adoquery1.SQL.Add('select * from student where 学号='''+edit24.text+'''');
    adoquery1.Open;
    if adoquery1.FieldByName('学号').AsString<>'' then
      showmessage('该学号已存在') //----提示学号已存在的信息----
    else
    begin                      //-----插入学生信息----
      //----设置初始密码为123
      adocommand1.CommandText:='insert into student values('''+edit24.Text+''','''+edit25.Text+''','''+edit26.Text+''','''+edit27.Text+''',''123'')';
      adocommand1.Execute;
      showmessage('添加学生成功');
      button19.Click; //-----触发Button19-----
    end;
  end;
end;

procedure TManagerView.Button21Click(Sender: TObject);    //----修改学生信息
begin
  if (edit24.Text='') or (edit25.text='') or (edit26.Text='') or(edit27.Text='') then
    showmessage('学生信息必须完整')      //-----提示输入信息必须完整的信息--
  else
  begin
    adoquery1.Close;
    adoquery1.SQL.Clear;
    adoquery1.SQL.Add('select * from student where 学号='''+edit24.text+'''');
    adoquery1.Open;
    if adoquery1.FieldByName('学号').AsString='' then
      showmessage('该学号不存在') //----提示学号不存在的信息----
    else
    begin                      //-----修改学生信息----
      adocommand1.CommandText:='update student set 姓名='''+edit25.Text+''' where 学号='''+edit24.text+'''';
      adocommand1.Execute;
      adocommand1.CommandText:='update student set 班级='''+edit26.Text+''' where 学号='''+edit24.text+'''';
      adocommand1.Execute;
      adocommand1.CommandText:='update student set 学院='''+edit27.Text+''' where 学号='''+edit24.text+'''';
      adocommand1.Execute;
      showmessage('修改成功');
      button19.Click; //-----触发Button19-----
    end;
  end;
end;

procedure TManagerView.Button2Click(Sender: TObject);
begin
  panel1.Visible:=false;     //------显示panel2------
  panel2.Visible:=true;
  panel3.Visible:=false;
  stringgrid2.Cells[0,0]:='序号';
  stringgrid2.Cells[1,0]:='课程号';
  stringgrid2.Cells[2,0]:='课程名';
  stringgrid2.Cells[3,0]:='教工号';
  stringgrid2.Cells[4,0]:='课程时段';
  stringgrid2.Cells[5,0]:='教室编号';
  stringgrid2.Cells[6,0]:='学分';
  stringgrid2.Cells[7,0]:='学时';
  stringgrid2.ColWidths[0]:=50;
  stringgrid2.ColWidths[1]:=150;
  stringgrid2.ColWidths[2]:=150;
  stringgrid2.ColWidths[3]:=100;
  stringgrid2.ColWidths[4]:=100;
  stringgrid2.ColWidths[5]:=100;
  stringgrid2.ColWidths[6]:=65;
  stringgrid2.ColWidths[7]:=65;
  button10.Click;  //----相当于触发了button10(查询按钮）---
end;

procedure TManagerView.Button3Click(Sender: TObject);
begin
  panel1.Visible:=false;
  panel2.Visible:=false;
  panel3.Visible:=true;
  button14.Click;
  button19.Click;       //----触发button14和button19
end;

procedure TManagerView.Button4Click(Sender: TObject);  //----教室查询-----
begin
  button6.Visible:=false;
  button7.Visible:=false;
  stringgrid1.ColCount:=5;              //-----设置stringgrid的列名和列宽----
  stringgrid1.Cells[0,0]:='序号';
  stringgrid1.Cells[1,0]:='教室编号';
  stringgrid1.Cells[2,0]:='教室名称';
  stringgrid1.Cells[3,0]:='容量';
  stringgrid1.Cells[4,0]:='教室类型';
  stringgrid1.ColWidths[0]:=40;
  stringgrid1.ColWidths[1]:=90;
  stringgrid1.ColWidths[2]:=165;
  stringgrid1.ColWidths[3]:=60;
  stringgrid1.ColWidths[4]:=165;
  adoquery1.Close;
  adoquery1.SQL.Clear;
  adoquery1.SQL.Add('(select * from classroom)');
  if combobox1.Text<>'' then
    adoquery1.SQL.Add('intersect (select * from classroom where 类型 like '''+'%'+combobox1.Text+'%'+''')');
  if edit1.Text<>'' then
    adoquery1.SQL.Add('intersect (select * from classroom where 容量>= '+edit1.text+')');
  if edit2.Text<>'' then
    adoquery1.SQL.Add('intersect (select * from classroom where 容量<= '+edit2.text+')');
  if edit3.Text<>'' then
    adoquery1.SQL.Add('intersect (select * from classroom where 编号 like '''+'%'+edit3.Text+'%'+''')');
  if edit7.Text<>'' then
    adoquery1.SQL.Add('intersect (select * from classroom where 名称 like '''+'%'+edit7.Text+'%'+''')');
  adoquery1.Open;
  stringgrid1.Rowcount:=1;          //---将数据传入stringdrid中-----
  while not adoquery1.Eof do
  begin
    stringgrid1.Cells[0,stringgrid1.RowCount]:=inttostr(stringgrid1.RowCount);
    stringgrid1.Cells[1,stringgrid1.RowCount]:=adoquery1.fieldbyname('编号').AsString;
    stringgrid1.Cells[2,stringgrid1.RowCount]:=adoquery1.fieldbyname('名称').AsString;
    stringgrid1.Cells[3,stringgrid1.RowCount]:=adoquery1.fieldbyname('容量').AsString;
    stringgrid1.Cells[4,stringgrid1.RowCount]:=adoquery1.fieldbyname('类型').AsString;
    stringgrid1.RowCount:=stringgrid1.RowCount+1;
    adoquery1.Next;
  end;
end;

procedure TManagerView.Button5Click(Sender: TObject);
   //----教室使用查询------
var
  i:integer;
  temp:string;
begin
  button6.Visible:=false;
  button7.Visible:=false;
  stringgrid1.ColCount:=6;              //-----设置stringgrid的列名和列宽----
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
  temp:=combobox2.Text+combobox3.Text;
  adoquery1.Close;               //-----查询并加入学生借用教室的信息-------
  adoquery1.SQL.Clear;
  if (combobox2.Text<>'') or (combobox3.Text<>'')  then
    adoquery1.SQL.Add('(select 编号,名称,学号,借用时段 from classroom ,stu_classroom where  stu_classroom.借用时段 like'''+'%'+temp+'%'+''' and stu_classroom.教室编号=classroom.编号) ')
  else
    adoquery1.SQL.Add('(select 编号,名称,学号,借用时段 from classroom ,stu_classroom where classroom.编号=stu_classroom.教室编号)');
  if (combobox1.text<>'') and (combobox1.Text<>' ') then
    adoquery1.SQL.Add('intersect (select 编号,名称,学号,借用时段 from classroom ,stu_classroom where classroom.类型 like '''+'%'+combobox1.text+'%'+'''and stu_classroom.教室编号=classroom.编号) ');
  if (edit1.Text<>'') and (edit1.Text<>' ') then
    adoquery1.SQL.Add('intersect (select 编号,名称,学号,借用时段 from classroom ,stu_classroom where classroom.容量>='+edit1.text+'and stu_classroom.教室编号=classroom.编号) ');
  if (edit2.Text<>'') and (edit2.Text<>' ') then
    adoquery1.SQL.Add('intersect (select 编号,名称,学号,借用时段 from classroom ,stu_classroom where classroom.容量<='+edit2.text+'and stu_classroom.教室编号=classroom.编号) ');
  if (edit3.Text<>'') and (edit3.Text<>' ') then
    adoquery1.SQL.Add('intersect (select 编号,名称,学号,借用时段 from classroom ,stu_classroom where stu_classroom.教室编号=classroom.编号 and classroom.编号 like '''+'%'+edit3.Text+'%'+''')');
  if (edit7.Text<>'') and (edit7.Text<>' ') then
    adoquery1.SQL.Add('intersect (select 编号,名称,学号,借用时段 from classroom ,stu_classroom where stu_classroom.教室编号=classroom.编号 and classroom.名称 like '''+'%'+edit7.Text+'%'+''')');
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
    adoquery1.SQL.Add('intersect (select 编号,名称,教工号,借用时段 from classroom ,tea_classroom where classroom.类型 like '''+'%'+combobox1.text+'%'+'''and tea_classroom.教室编号=classroom.编号) ');
  if (edit1.Text<>'') and (edit1.Text<>' ') then
    adoquery1.SQL.Add('intersect (select 编号,名称,教工号,借用时段 from classroom ,tea_classroom where classroom.容量>='+edit1.text+'and tea_classroom.教室编号=classroom.编号) ');
  if (edit2.Text<>'') and (edit2.Text<>' ') then
    adoquery1.SQL.Add('intersect (select 编号,名称,教工号,借用时段 from classroom ,tea_classroom where classroom.容量<='+edit2.text+'and tea_classroom.教室编号=classroom.编号) ');
  if (edit3.Text<>'') and (edit3.Text<>' ') then
    adoquery1.SQL.Add('intersect(select 编号,名称,教工号,借用时段 from classroom ,tea_classroom where tea_classroom.教室编号=classroom.编号 and classroom.编号 like '''+'%'+edit3.Text+'%'+''')');
  if (edit7.Text<>'') and (edit7.Text<>' ') then
    adoquery1.SQL.Add('intersect(select 编号,名称,教工号,借用时段 from classroom ,tea_classroom where tea_classroom.教室编号=classroom.编号 and classroom.名称 like '''+'%'+edit7.Text+'%'+''')');
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
    adoquery1.SQL.Add('(select  编号,名称,课程号,时段 from classroom ,course where  时段 like'''+'%'+temp+'%'+'''  and 教室编号=classroom.编号) ')
  else
    adoquery1.SQL.Add('(select  编号,名称,课程号,时段 from classroom ,course where 编号=教室编号)');
  if (combobox1.text<>'') and (combobox1.Text<>' ') then
    adoquery1.SQL.Add('intersect (select  编号,名称,课程号,时段 from classroom ,course where classroom.类型 like '''+'%'+combobox1.text+'%'+'''and 教室编号=classroom.编号) ');
  if (edit1.Text<>'') and (edit1.Text<>' ') then
    adoquery1.SQL.Add('intersect (select  编号,名称,课程号,时段 from classroom ,course where classroom.容量>='+edit1.text+'and 教室编号=classroom.编号) ');
  if (edit2.Text<>'') and (edit2.Text<>' ') then
    adoquery1.SQL.Add('intersect (select  编号,名称,课程号,时段 from classroom ,course where classroom.容量<='+edit2.text+'and 教室编号=classroom.编号) ');
  if (edit3.Text<>'') and (edit3.Text<>' ') then
    adoquery1.SQL.Add('intersect (select  编号,名称,课程号,时段 from classroom ,course where cou_student.教室编号=classroom.编号 and classroom.编号 like '''+'%'+edit3.Text+'%'+''')');
  if (edit7.Text<>'') and (edit7.Text<>' ') then
    adoquery1.SQL.Add('intersect (select  编号,名称,课程号,时段 from classroom ,course where cou_student.教室编号=classroom.编号 and classroom.名称 like '''+'%'+edit7.Text+'%'+''')');
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


procedure TManagerView.Button6Click(Sender: TObject);
begin
  //---删除教室表中的教室信息----
  adocommand1.CommandText:='delete from classroom where 编号='''+stringgrid1.Cells[1,CurrentRow]+'''';
  adocommand1.Execute;
  //----删除Stu_classroom中的信息----
  adocommand1.CommandText:='delete from stu_classroom where 教室编号='''+stringgrid1.Cells[1,CurrentRow]+'''';
  adocommand1.Execute;
  //----删除Tea_classroom中的信息----
  adocommand1.CommandText:='delete from tea_classroom where 教室编号='''+stringgrid1.Cells[1,CurrentRow]+'''';
  adocommand1.Execute;
  //----更新课程信息----
  adocommand1.CommandText:='update course set 教室编号='''+''' where 教室编号='''+stringgrid1.Cells[1,CurrentRow]+'''';
  adocommand1.Execute;
  showmessage('删除成功');
  button4.Click;  //---更新Stringgrid中的内容----
end;

procedure TManagerView.Button7Click(Sender: TObject);
begin
  if stringgrid1.Cells[3,currentrow]='学生' then
  begin
    adocommand1.CommandText:='delete from stu_classroom where 教室编号='''+stringgrid1.Cells[1,CurrentRow]+''' and 学号='''+stringgrid1.cells[4,currentRow]+''' and 借用时段='''+stringgrid1.cells[5,currentrow]+'''';
    adocommand1.Execute;
  end;
  if stringgrid1.Cells[3,currentrow]='教师' then
  begin
    adocommand1.CommandText:='delete from tea_classroom where 教室编号='''+stringgrid1.Cells[1,CurrentRow]+''' and 教工号='''+stringgrid1.cells[4,currentRow]+''' and 借用时段='''+stringgrid1.cells[5,currentrow]+'''';
    adocommand1.Execute;
  end;
  showmessage('删除成功');
  button5.Click;  //-----更新stringgrid中的内容------
end;


procedure TManagerView.Button8Click(Sender: TObject);         //----新增教室-----
begin
  button6.Visible:=false;
  button7.Visible:=false;
  if (combobox4.Text='') or (edit4.Text='') or(edit5.Text='') or (edit6.Text='') then
    showmessage('请输入完整的教室信息')             //----提示输入完整的教室信息----
  else
  begin
    adoquery1.close;
    adoquery1.sql.Clear;
    adoquery1.SQL.Add('select * from classroom where classroom.编号='''+edit5.text+'''');
    adoquery1.Open;
    if adoquery1.FieldByName('编号').AsString<>'' then     //---如果该教室编号存在，提示信息
      showmessage('该教室已存在')
    else
    begin                               //----添加新教室----
      adocommand1.CommandText:='insert into classroom values('''+edit5.text+''','''+edit6.text+''','''+edit4.text+''','''+combobox4.text+''')';
      adocommand1.Execute;
      showmessage('添加成功');
      //-----清空内容------
      combobox1.Text:='';
      combobox2.Text:='';
      combobox3.Text:='';
      edit1.Text:='';
      edit2.Text:='';
      edit3.Text:='';
      edit7.Text:='';
      button4.Click;  //-----刷新Stringgrid中的内容-------
    end;
  end;

end;

procedure TManagerView.Button9Click(Sender: TObject);
begin
  button6.Visible:=false;
  button7.Visible:=false;
  if (combobox4.Text='') or (edit4.Text='') or(edit5.Text='') or (edit6.Text='') then
    showmessage('请输入完整的教室信息')             //----提示输入完整的教室信息----
  else
  begin
    adoquery1.close;
    adoquery1.sql.Clear;
    adoquery1.SQL.Add('select * from classroom where classroom.编号='''+edit5.text+'''');
    adoquery1.Open;
    if adoquery1.FieldByName('编号').AsString='' then     //---如果该教室编号不存在，提示信息
      showmessage('该教室不存在')
    else
    begin                               //----修改教室----
      adocommand1.CommandText:='update classroom set 名称='''+edit6.Text+''' where 编号='''+edit5.Text+'''';
      adocommand1.Execute;
      adocommand1.CommandText:='update classroom set 容量='''+edit4.Text+''' where 编号='''+edit5.Text+'''';
      adocommand1.Execute;
      adocommand1.CommandText:='update classroom set 类型='''+combobox4.Text+''' where 编号='''+edit5.Text+'''';
      adocommand1.Execute;
      showmessage('修改成功');
      //-----清空内容------
      combobox1.Text:='';
      combobox2.Text:='';
      combobox3.Text:='';
      edit1.Text:='';
      edit2.Text:='';
      edit3.Text:='';
      edit7.Text:='';
      button4.Click;  //-----刷新Stringgrid中的内容-------
    end;
  end;

end;

procedure TManagerView.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Login.close;//---关闭整个程序----
end;

procedure TManagerView.FormShow(Sender: TObject);
begin
  button1.Click;      //-----触发Button1
end;

procedure TManagerView.StringGrid1SelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);//------------------选中stringgrid中的内容，判断是否显示‘删除教室’或‘删除使用’的按钮
begin
  CurrentRow:=ARow;
  if ARow=0 then                  //----如果当前行是第一行，则令两个按键均不可见-----
  begin
    button6.Visible:=false;
    button7.Visible:=false;
  end
  else if stringgrid1.ColCount=5 then
  begin                          //----如果列数为5（即显示教室查询时）设置‘删除教室’按钮可见，‘删除使用’按钮不可见
    button6.Visible:=true;
    button7.Visible:=false;
    edit5.Text:=stringgrid1.Cells[1,ARow];
    edit6.Text:=stringgrid1.Cells[2,ARow];
    edit4.Text:=stringgrid1.Cells[3,ARow];
    combobox4.Text:=stringgrid1.Cells[4,ARow];
  end
  else                    //----如果列数不为5（即显示教室使用查询时）设置‘删除教室’按钮不可见，‘删除使用’按钮可见
  begin
    if stringgrid1.Cells[3,ARow]='课程' then  //----如果是课程占用的时间  则不可删除（即不显示）
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
  if ARow=0 then                  //----如果当前行是第一行，则令删除按钮不可见-----
  begin
    button13.Visible:=false;
  end
  else                     //----使‘删除’按钮可见
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
  if ARow=0 then                  //----如果当前行是第一行，则令删除按钮不可见-----
  begin
    button17.Visible:=false;
  end
  else                     //----使‘删除教师’按钮可见
  begin
    edit18.Text:=stringgrid3.Cells[1,ARow];      //----将选中的信息传回edit框中---
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
  if ARow=0 then                  //----如果当前行是第一行，则令删除按钮不可见-----
  begin
    button18.Visible:=false;
  end
  else                     //----使‘删除学生’按钮可见
  begin
    edit24.Text:=stringgrid4.Cells[1,ARow];      //----将选中的信息传回edit框中---
    edit25.Text:=stringgrid4.Cells[2,ARow];
    edit26.Text:=stringgrid4.Cells[3,ARow];
    edit27.Text:=stringgrid4.Cells[4,ARow];
    button18.Visible:=true;
  end;
end;

end.
