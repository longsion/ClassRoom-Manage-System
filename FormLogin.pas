unit FormLogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, jpeg, ExtCtrls, StdCtrls, DB, ADODB;

type
  TLogin = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    GroupBox1: TGroupBox;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    Button1: TButton;
    Button2: TButton;
    ADOQuery1: TADOQuery;
    procedure Button1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Login: TLogin;

implementation
  uses FormReg, FormStudent, FormTeacher, FormManager;

{$R *.dfm}

procedure TLogin.Button1Click(Sender: TObject);     //----显示注册窗口-----
begin
  reg.show;
end;

procedure TLogin.Button2Click(Sender: TObject);
begin
  if checkbox1.Checked=true then
  begin
    adoquery1.Close;
    adoquery1.SQL.Clear;
    adoquery1.SQL.Add('select * from student where 学号='''+edit1.text+'''');
    adoquery1.Open;
    if adoquery1.FieldByName('学号').AsString='' then           //---提示学号不存在---
      showmessage('不存在该学号')
    else
    begin
      adoquery1.Close;
      adoquery1.SQL.Clear;
      adoquery1.SQL.Add('select * from student where (学号='''+edit1.text+''')'+'and(密码='''+edit2.text+''')');
      adoquery1.Open;
      if adoquery1.FieldByName('学号').AsString='' then      //---如果学号存在，密码错误 提示密码输入错误---
        showmessage('密码输入错误')
      else                               //----打开学生界面----
      begin
        studentview.Show;
        adoquery1.Close;
        adoquery1.SQL.Clear;
        adoquery1.SQL.Add('select 姓名 from student where 学号='''+edit1.text+'''');
        adoquery1.Open;     //----向学生界面中Statusbar中添加显示 姓名和学号---
        studentview.StatusBar1.Panels[1].Text:=adoquery1.FieldByName('姓名').AsString;
        studentview.StatusBar1.Panels[2].Text:=edit1.text;
        Login.Hide;
      end;
    end;
  end;

  if checkbox2.Checked=true then
  begin
    adoquery1.Close;
    adoquery1.SQL.Clear;
    adoquery1.SQL.Add('select * from teacher where 教工号='''+edit1.text+'''');
    adoquery1.Open;
    if adoquery1.FieldByName('教工号').AsString='' then         //---提示教工号不存在---
      showmessage('不存在该教工号')
    else
    begin
      adoquery1.Close;
      adoquery1.SQL.Clear;
      adoquery1.SQL.Add('select * from teacher where (教工号='''+edit1.text+''')'+'and(密码='''+edit2.text+''')');
      adoquery1.Open;
      if adoquery1.FieldByName('教工号').AsString='' then    //---如果教工号存在，密码错误 提示密码输入错误--
        showmessage('密码输入错误')
      else
      begin                               //----打开教师界面----
        teacherview.Show;
        adoquery1.Close;
        adoquery1.SQL.Clear;
        adoquery1.SQL.Add('select 姓名 from teacher where 教工号='''+edit1.text+'''');
        adoquery1.Open;     //----向教师界面中Statusbar中添加显示 姓名和教工号---
        teacherview.StatusBar1.Panels[1].Text:=adoquery1.FieldByName('姓名').AsString;
        teacherview.StatusBar1.Panels[2].Text:=edit1.text;
        Login.Hide;
      end;
    end;
  end;

  if checkbox3.Checked=true then
  begin
    adoquery1.Close;
    adoquery1.SQL.Clear;
    adoquery1.SQL.Add('select * from manager where 管理员号='''+edit1.text+'''');
    adoquery1.Open;
    if adoquery1.FieldByName('管理员号').AsString='' then   //----提示管理员号不存在----
      showmessage('不存在该管理员号')
    else
    begin
      adoquery1.Close;
      adoquery1.SQL.Clear;
      adoquery1.SQL.Add('select * from manager where (管理员号='''+edit1.text+''')'+'and(密码='''+edit2.text+''')');
      adoquery1.Open;
      if adoquery1.FieldByName('管理员号').AsString='' then    //---如果管理员号存在，而密码输入错误，提示密码输入错误--
        showmessage('密码输入错误')
      else
      begin                //----打开管理员界面----
        managerview.Show;
        adoquery1.Close;
        adoquery1.SQL.Clear;
        adoquery1.SQL.Add('select 姓名 from manager where 管理员号='''+edit1.text+'''');
        adoquery1.Open;     //----向管理员界面中Statusbar中添加显示 姓名和管理员号---
        managerview.StatusBar1.Panels[1].Text:=adoquery1.FieldByName('姓名').AsString;
        managerview.StatusBar1.Panels[2].Text:=edit1.text;
        Login.Hide;
      end;
    end;
  end;
end;

procedure TLogin.CheckBox1Click(Sender: TObject);
begin
  if CheckBox1.Checked=true then        //如果选中，其他两个设置为未选中
  begin
    CheckBox2.Checked:=false;
    CheckBox3.Checked:=false;
    label2.caption:='学号:';
  end;
  if (CheckBox1.checked=false) and(CheckBox2.checked=false)and(CheckBox3.checked=false) then
  begin                  //如果3个都未选中，则默认checkbox1被选中
    CheckBox1.Checked:=true;
    label2.Caption:='学号:';
  end;
end;

procedure TLogin.CheckBox2Click(Sender: TObject);
begin
  if CheckBox2.Checked=true then          //如果选中，其他两个设置为未选中
  begin
    CheckBox1.Checked:=false;
    CheckBox3.Checked:=false;
    label2.caption:='教工号:';
  end;
  if (CheckBox1.checked=false) and(CheckBox2.checked=false)and(CheckBox3.checked=false) then
  begin                          //如果3个都未选中，则默认checkbox1被选中
    CheckBox1.Checked:=true;
    label2.Caption:='学号:';
  end;

end;


procedure TLogin.CheckBox3Click(Sender: TObject);
begin
  if CheckBox3.Checked=true then          //如果选中，其他两个设置为未选中
  begin
    CheckBox1.Checked:=false;
    CheckBox2.Checked:=false;
    label2.caption:='管理员号:';
  end;
  if (CheckBox1.checked=false) and(CheckBox2.checked=false)and(CheckBox3.checked=false) then
  begin                          //如果3个都未选中，则默认checkbox1被选中
    CheckBox1.Checked:=true;
    label2.Caption:='学号:';
  end;
end;

end.
