unit Targets;

interface
  type
  //������� �����
  TTarget = class
    x0, y0: real;       //��������� ����������
    x, y: real;         //������� ����������
    v: real;            //��������
    alfa: real;         //����
    target_type: integer;       //��� ����: 0 ��� 1
    time: real;                 //������� �����
    constructor create(init_x, init_y, init_v, init_time: real; init_ttype: integer);  //����������� � �������� ��������� ����������
    procedure move(ti: real); virtual; abstract;        //������������
    destructor des;                                     //���������� (������)
  end;

  //������
  TAircraft = class(TTarget)
    constructor create(init_x, init_y, init_v, init_time: real; init_ttype: integer);
    procedure move(ti: real); override; //����������� ��� ��������� ���������� � ��������
  end;

  //������
  TMissle = class(TTarget)
    acc: real; //����������� ���������
    constructor create(init_x, init_y, init_v, init_a, init_time: real; init_ttype: integer);
    procedure move(ti: real); override; //����������� ��� ��������� ����������, �������� ��������
  end;

implementation

  constructor TTarget.create(init_x, init_y, init_v, init_time: real; init_ttype: integer);
  //������� ��������� ����������
  begin
    x0 := init_x; x := init_x;
    y0 := init_y; y := init_y;
    v := init_v;
    time := init_time;
    target_type := init_ttype;
    //����������� ����
    if x = 0 then
      if y > 0 then alfa := pi/2
      else begin if y < 0 then alfa := pi/2; end
    else begin
      alfa := arctan(y0/x0);
      if (x < 0) and ((y > 0) or (y < 0)) then alfa := alfa + pi;
    end;
  end;

  destructor TTarget.des;
  begin
  end;

  constructor TAircraft.create(init_x, init_y, init_v, init_time: real; init_ttype: integer);
  //target_type = 0 - ������, ����� �����������
  begin
    inherited create(init_x, init_y, init_v, init_time, 0);
  end;

  procedure TAircraft.move(ti: real);
  //�������� ������������ ��� ��������� ��������
  begin
    x := x - v*(ti - time)*cos(alfa);
    y := y - v*(ti - time)*sin(alfa);
    time := ti;
  end;

  constructor TMissle.create(init_x: Real; init_y: Real; init_v: Real; init_a: Real; init_time: Real; init_ttype: integer);
  //target_type = 1
  begin
    inherited create(init_x, init_y, init_v, init_time, 1);
    acc := init_a;
  end;

  procedure TMissle.move(ti: Real);
  //���������������� �������� �� ������
  begin
    x := x - (v+acc*(ti-time))*(ti-time)*cos(alfa);
    y := y - (v+acc*(ti-time))*(ti-time)*sin(alfa);
    v := v + acc*(ti - time);
    time := ti;
  end;

end.