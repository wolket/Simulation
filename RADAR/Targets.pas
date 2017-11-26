unit Targets;

interface
  type
  TTargetType = (Air, Mis);
  //������� �����
  TTarget = class
    x0, y0: real;       //��������� ����������
    x, y: real;         //������� ����������
    v: real;            //��������
    alfa: real;         //����
    targetType: TTargetType;       //��� ����
    time: real;                 //������� �����
    constructor create(initParam: array of real);  //����������� � �������� ��������� ����������
    procedure move(ti: real); virtual; abstract;        //������������
    destructor destroy;                                     //���������� (������)
  end;

  //������
  TAircraft = class(TTarget)
    constructor create(initParam: array of real);
    procedure move(ti: real); override; //����������� ��� ��������� ���������� � ��������
  end;

  //������
  TMissile = class(TTarget)
    acc: real; //����������� ���������
    constructor create(initParam: array of real);
    procedure move(ti: real); override; //����������� ��� ��������� ����������, �������� ��������
  end;

implementation

  constructor TTarget.create(initParam: array of real);
  //������� ��������� ����������
  begin
    x0 := initParam[0]; x := initParam[1];
    y0 := initParam[0]; y := initParam[1];
    time := initParam[2];
    v := initParam[3];
    //����������� ����
    if x = 0 then
      if y > 0 then alfa := pi/2
      else begin if y < 0 then alfa := pi/2; end
    else begin
      alfa := arctan(y0/x0);
      if (x < 0) and ((y > 0) or (y < 0)) then alfa := alfa + pi;
    end;
  end;

  destructor TTarget.destroy;
  begin
  end;

  constructor TAircraft.create(initParam: array of real);
  begin
    inherited create(initParam);
    TargetType := Air;
  end;

  procedure TAircraft.move(ti: real);
  //�������� ������������ ��� ��������� ��������
  begin
    x := x - v*(ti - time)*cos(alfa);
    y := y - v*(ti - time)*sin(alfa);
    time := ti;
  end;

  constructor TMissile.create(initParam: array of real);
  begin
    inherited create(initParam);
    acc := initParam[4];
    TargetType := Air;
  end;

  procedure TMissile.move(ti: Real);
  //���������������� �������� �� ������
  begin
    x := x - (v+acc*(ti-time))*(ti-time)*cos(alfa);
    y := y - (v+acc*(ti-time))*(ti-time)*sin(alfa);
    v := v + acc*(ti - time);
    time := ti;
  end;

end.
