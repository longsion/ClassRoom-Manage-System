program 教师管理系统;

uses
  Forms,
  FormLogin in 'FormLogin.pas' {Login},
  FormReg in 'FormReg.pas' {reg},
  FormStudent in 'FormStudent.pas' {StudentView},
  FormTeacher in 'FormTeacher.pas' {TeacherView},
  FormManager in 'FormManager.pas' {ManagerView};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TLogin, Login);
  Application.CreateForm(Treg, reg);
  Application.CreateForm(TStudentView, StudentView);
  Application.CreateForm(TTeacherView, TeacherView);
  Application.CreateForm(TManagerView, ManagerView);
  Application.Run;
end.
