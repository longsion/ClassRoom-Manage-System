unit FormReg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, jpeg, DB, ADODB;

type
  Treg = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    ComboBox1: TComboBox;
    Label6: TLabel;
    Edit4: TEdit;
    Label7: TLabel;
    Edit5: TEdit;
    Label8: TLabel;
    Edit6: TEdit;
    Button1: TButton;
    Label9: TLabel;
    Label10: TLabel;
    ADOCommand1: TADOCommand;
    ADOQuery1: TADOQuery;
    ComboBox2: TComboBox;
    procedure FormShow(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure Edit4Change(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  reg: Treg;

implementation
  uses FormLogin;

{$R *.dfm}

procedure Treg.Button1Click(Sender: TObject);
begin
  if (edit1.Text='') or (edit2.text='') then
  begin                                     //----提示至少输入学号/教工号 和姓名
    if combobox1.Text='学生' then
      showmessage('请至少输入学号和姓名')
    else
      showmessage('请至少输入教工号和姓名');
  end
  else if label10.Visible=true then
       showmessage('两次输入的密码不一致')
  else
  begin
    if combobox1.Text='学生' then
    begin
      adocommand1.CommandText:='insert into student values('''+edit1.Text+''','''+edit2.Text+''','''+edit5.Text+''','''+edit6.text+''','''+edit3.Text+''')' ;
      adoquery1.Close;
      adoquery1.SQL.Clear;
      adoquery1.SQL.Add('select * from student where 学号='''+edit1.text+'''');
    end
    else
    begin
      adocommand1.CommandText:='insert into teacher values('''+edit1.Text+''','''+edit2.Text+''','''+edit5.Text+''','''+edit6.text+''','''+combobox2.text+''','''+edit3.Text+''')';
      adoquery1.Close;
      adoquery1.SQL.Clear;
      adoquery1.SQL.Add('select * from teacher where 教工号='''+edit1.text+'''');
    end;
    adoquery1.open;
    if adoquery1.FieldByName('姓名').AsString<>'' then        //如果该学号/教工号 已被注册 显示提示信息
      showmessage('该用户名已被注册')
    else
    begin
      adocommand1.Execute;
      showmessage('注册成功');
      Reg.Close;
    end;
  end;

end;

procedure Treg.ComboBox1Change(Sender: TObject);
begin
  if combobox1.Text='教师' then         //如果选中的是教师，则设置相应的LABEL和EDIT和COMBOBOX
  begin
    label3.Caption:='教工号:';
    label7.Caption:='电话:';
    label8.Caption:='邮箱:';
    label9.Visible:=true;
    label9.Caption:='等级:';
    combobox2.Visible:=true;
    edit1.Clear;
    edit2.Clear;
    edit3.Clear;
    edit4.Clear;
    edit5.Clear;
    edit6.Clear;
  end
  else                              //如果选中的是学生，则设置相应的LABEL和EDIT和COMBOBOX
  begin
    label3.Caption:='学号:';
    label7.caption:='班级:';
    label8.caption:='学院:';
    label9.Visible:=false;
    combobox2.Visible:=false;
    edit1.Clear;
    edit2.Clear;
    edit3.Clear;
    edit4.Clear;
    edit5.Clear;
    edit6.Clear;
  end;

end;

procedure Treg.Edit3Change(Sender: TObject);  //----如果两次输入的密码不一致，则显示提示
begin
  if edit3.Text<>edit4.Text then
    label10.Visible:=true
  else
    label10.Visible:=false;
end;

procedure Treg.Edit4Change(Sender: TObject);  //----如果两次输入的密码不一致，则显示提示
begin
  if edit4.Text<>edit3.text then
    label10.Visible:=true
  else
    label10.Visible:=false;
end;

procedure Treg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Login.Show;  //显示登录窗口
end;

procedure Treg.FormShow(Sender: TObject);
begin
  Login.Hide; //隐藏登陆窗口
  combobox1.Text:='学生';
  combobox2.Visible:=false;
end;

end.
