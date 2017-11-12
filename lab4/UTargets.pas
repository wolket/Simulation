Unit UTargets;

interface
  uses System.Generics.Collections, UIntegrator, Winapi.Windows, Winapi.Messages;

  const WM_DRAW_SIMULATION = WM_USER+1;

  type
    TTargetType = (Air, Mis);
    TPoint = record
      x, y: real;
    end;

    TTargetMoveParam = record
      P: real;
      P0: real;
      dm: real;
      mFuel: real;
      mCritFuel: real;
    end;

    TResistParam = record
      X: real;
      Cx: real;
      S: real;
      const ro = 1.029;
    end;

    TPosObject = class
      public
        CurPosition: TPoint;
        InitPosition: TPoint;
        procedure Move(ti: real);
        constructor Create(initParam: array of real);
        destructor Destroy;
        function GetTime: real;

        property Time: real read GetTime write Move;
      protected
        CurTime: real;
    end;

    TTarget = class (TPosObject)
      public
        TargetType: TTargetType;
        MoveParam: TTargetMoveParam;
        ResistParam: TResistParam;

        constructor Create(TargetType: TTargetType; initParam: array of real);
        function CalcMFuel(ti:real): real; virtual; abstract;
        function CalcResist(ti:real): real; virtual; abstract;
        function CalcP(ti: real): real; virtual; abstract;
        function CalcV(ti: real): real; virtual; abstract;
        function CalcX(ti: real): real; virtual; abstract;
        function CalcY(ti: real): real; virtual; abstract;
        function CalcTime(ti: real): real;

        function GetV: real;
        procedure SetV(newV: real);
        function GetMass: real;
        procedure SetMass(newMass: real);

        destructor Destroy;

        property V: real read GetV write SetV;
        property Mass: real read GetMass write SetMass;

      protected
        Course: real;
        TargetV: real;
        TargetMass: real;

    end;

    TAircraft = class (TTarget)
      public

        constructor Create(initParam: array of real);
        function CalcMFuel(ti:real): real; override;
        function CalcResist(ti:real): real; override;
        function CalcP(ti: real): real; override;
        function CalcV(ti: real): real; override;
        function CalcX(ti: real): real; override;
        function CalcY(ti: real): real; override;

    end;

    TMissile = class (TTarget)
      public

        constructor Create(initParam: array of real);
        function CalcMFuel(ti:real): real; override;
        function CalcResist(ti:real): real; override;
        function CalcP(ti: real): real; override;
        function CalcV(ti: real): real; override;
        function CalcX(ti: real): real; override;
        function CalcY(ti: real): real; override;

    end;

    TCommandPost = class (TPosObject)
      public
        SafetyDistance: real;
        procedure Move(ti: real);
        constructor Create(initParam: array of real);
    end;

    TRLS = class (TPosObject)
      public
        Distance: real;
        Course: real;
        RMax: real;
        function Peleng(ti: real; Target: TTarget): boolean;
        procedure Move(ti: real);
        constructor Create(initParam: array of real);
    end;

    TTargetList = class (TList<TTarget>)
      public
        function AddTarget(TargetType: TTargetType; initParam: array of real): integer;
        procedure InsertTarget(index: integer; TargetType: TTargetType; initParam: array of real);
        procedure Clear;
    end;

    TTargetIntegrator = Class(TAIntegrator)
      public
        procedure Run(var Target: TTarget; t0: real; tk: real);
      protected
        procedure CalcTarget(var Target: TTarget; Time, Dt: real);
    End;

    TSimulator = class
      public
        TargetCount: integer;
        Targets: TTargetList;
        CP: TCommandPost;
        RLS: TRLS;
        FT: Text;
        T0: real;
        TK: real;
        DT: real;
        Integrator: TTargetIntegrator;
        procedure Run;
        constructor Create(initParam: array of real; hander: hWnd);
        destructor Destroy;
      protected
        Handler: hWnd;
    end;

implementation

  constructor TPosObject.Create(initParam: array of Real);
  begin
    self.CurPosition.x := initParam[0];
    self.CurPosition.y := initParam[1];
    self.InitPosition.x := initParam[0];
    self.InitPosition.y := initParam[1];
    self.CurTime := initParam[2];
  end;

  procedure TPosObject.Move(ti: Real);
  begin
    self.CurTime := ti;
  end;

  function TPosObject.GetTime: real;
  begin
    result := self.CurTime;
  end;

  destructor TPosObject.Destroy;
  begin
    //insert code here
  end;

  constructor TTarget.Create(TargetType: TTargetType; initParam: array of Real);
  begin
    inherited Create(initParam);
    self.TargetType := TargetType;
    if (self.CurPosition.x <> 0) then self.Course := arctan(self.CurPosition.y/self.CurPosition.x);
    if (self.CurPosition.x > 0) then self.Course := self.Course + pi;
    if (self.CurPosition.x = 0) then begin
      if self.CurPosition.y < 0 then self.Course := pi/2
      else self.Course := -pi/2;
    end;
    self.Mass := initParam[3];
    //����� ����������� ���� ����� ���� ������ �� ��, � MOVE �� ����� �����.
    with self.MoveParam do begin
      P0 := initParam[4];
      mFuel := initParam[5];
      dm := initParam[6];
      mCritFuel := initParam[7];
    end;
    with self.ResistParam do begin
      S := initParam[8];
      Cx := initParam[9];
    end;
  end;

  function TTarget.GetV: real;
  begin
    result := self.TargetV;
  end;

  procedure TTarget.SetV(newV: Real);
  begin
    if newV < 0 then self.TargetV := 0
    else self.TargetV := newV;
  end;

  function TTarget.GetMass;
  begin
    result := self.TargetMass;
  end;

  procedure TTarget.SetMass(newMass: Real);
  begin
    if newMass > 0 then self.TargetMass := NewMass
    else self.TargetMass := 1000;
  end;

  function TTarget.CalcTime(ti: Real): real;
  begin
    result := 1;
  end;

  destructor TTarget.Destroy;
  begin

  end;

  constructor TAircraft.Create(initParam: array of Real);
  begin
    inherited Create(Air, InitParam);
  end;

  function TAircraft.CalcMFuel(ti: Real): real;
  begin
    if self.MoveParam.mFuel > 0 then
      result := self.MoveParam.dm
    else result := 0;
  end;

  function TAircraft.CalcResist(ti: Real): real;
  begin
    with self.ResistParam do
      result := Cx*ro*sqr(self.V)*S/2;
  end;

  function TAircraft.CalcP(ti: Real): real;
  begin
    if self.MoveParam.mFuel <= self.MoveParam.mCritFuel then result := self.MoveParam.P0*(self.MoveParam.mFuel/self.MoveParam.mCritFuel)
    else result := self.MoveParam.P0;
  end;

  function TAircraft.CalcV(ti: Real): real;
  begin
    result := (self.MoveParam.P - self.ResistParam.X)/self.mass;
  end;

  function TAircraft.CalcX(ti: Real): real;
  begin
    result := self.V*cos(self.Course);
  end;

  function TAircraft.CalcY(ti: Real): real;
  begin
    result := self.V*sin(self.Course);
  end;

  constructor TMissile.Create(initParam: array of Real);
  begin
    inherited Create(Mis, InitParam);
  end;

  function TMissile.CalcMFuel(ti: Real): real;
  begin
    result := (-1)*self.MoveParam.dm;
  end;

  function TMissile.CalcResist(ti: Real): real;
  begin
    with self.ResistParam do
      result := Cx*ro*sqr(self.V)*S/2;
  end;

  function TMissile.CalcP(ti: Real): real;
  begin
    if self.MoveParam.mFuel <= self.MoveParam.mCritFuel then result := self.MoveParam.P0*(self.MoveParam.mFuel/self.MoveParam.mCritFuel)
    else result := self.MoveParam.P0;
  end;

  function TMissile.CalcV(ti: Real): real;
  begin
    result := (self.MoveParam.P - self.ResistParam.X)/self.mass;
  end;

  function TMissile.CalcX(ti: Real): real;
  begin
    result := self.V*cos(self.Course);
  end;

  function TMissile.CalcY(ti: Real): real;
  begin
    result := self.V*sin(self.Course);
  end;

  constructor TCommandPost.Create(initParam: array of Real);
  begin
    inherited Create(initParam);
    self.SafetyDistance := initParam[3];
  end;

  procedure TCommandPost.Move(ti: Real);
  begin
    inherited Move(ti);
  end;

  constructor TRLS.Create(initParam: array of Real);
  begin
    inherited Create(initParam);
    self.RMax := initParam[3];
    self.Distance := 0;
    self.Course := 0;
  end;

  procedure TRLS.Move(ti: Real);
  begin
    inherited Move(ti);
  end;

  function TRLS.Peleng(ti: Real; Target: TTarget): boolean;
  var dx, dy: real;
  begin
    self.Move(ti);
    self.Distance := sqrt(sqr(Target.CurPosition.x - self.CurPosition.x) +
                          sqr(Target.CurPosition.y - self.CurPosition.y));
    if Distance <= self.RMax then begin
      dx := Target.CurPosition.x - self.CurPosition.x;
      dy := Target.CurPosition.y - self.CurPosition.y;
      if dx = 0 then begin
        if dy > 0 then self.Course := pi/2;
        if dy < 0 then self.Course := - pi/2;
        if dy = 0 then self.Course := 0;
      end else
      if dy = 0 then self.Course := 0
      else self.Course := arctan(Dy/dx);
      if dx < 0 then self.Course := self.Course + pi;
      result := True;
    end else
      result := False;
  end;

  function TTargetList.AddTarget(TargetType: TTargetType; initParam: array of Real): integer;
  var Aircraft: TAircraft; Missile: TMissile;
  begin
    if TargetType = Air then Aircraft := TAircraft.Create(initParam)
    else Missile := TMissile.Create(initParam);
    if Aircraft <> Nil then self.Add(Aircraft)
    else self.Add(Missile);
    Aircraft := Nil; Missile := Nil;
    result := self.Count;
  end;

  procedure TTargetList.InsertTarget(index: integer; TargetType: TTargetType; initParam: array of Real);
  var Aircraft: TAircraft; Missile: TMissile;
  begin
    if TargetType = Air then Aircraft := TAircraft.Create(initParam)
    else Missile := TMissile.Create(initParam);
    if Aircraft <> Nil then self.Insert(index, Aircraft)
    else self.Insert(index, Missile);
    Aircraft := Nil; Missile := Nil;
  end;

  procedure TTargetList.Clear;
  var i: integer; target: TTarget;
  begin
    for i := 0 to self.Count - 1 do begin target := self.Items[i]; target.Destroy; end;
    self.Count := 0;
    self.Capacity := 0;
    inherited Clear;
  end;

  constructor TSimulator.Create(initParam: array of real; hander: hWnd);
  begin
    self.T0 := initParam[0];
    self.TK := initParam[1];
    self.DT := initParam[2];
    self.TargetCount := 0;
    self.Targets := TTargetList.Create;
    self.Handler := handler;
    assign(self.FT, 'Temp.txt');
    rewrite(self.FT);
    writeln(self.FT, '  time ;  Dist ; Course ;   V   ;  Type');
    close(self.FT);
  end;

  procedure TSimulator.Run;
  var time: real; item: integer; flag: boolean;
      Target: TTarget; newLine: boolean;
  begin
    assign(self.FT, 'temp.txt');
    append(self.FT);
    time := self.T0;
    flag := False; newLine := False;
    while time <= self.TK do begin
      for item := 0 to TargetCount-1 do begin
        Target := self.Targets.Items[item];
        self.Integrator.Run(Target, time, time+dt);
        flag := RLS.Peleng(time, Target);
        if flag then begin
          write(self.FT, time:7:3, ';', Target.CurPosition.x:7:3, ';', Target.CurPosition.y, ';', self.Targets[item].V:8:3);
          if Target.TargetType = Air then write(self.FT, ' Aircraft')
          else write(self.FT, ' Missile');
          newLine := flag;
        end;//if flag
      end;//for item
      time := time + self.DT;
      if newLine then writeln(self.FT, '');
      SendMessage(self.Handler, WM_DRAW_SIMULATION, 0, integer(self));
    end;//while time
    close(self.FT);
  end;//procedure

  destructor TSimulator.Destroy;
  begin
    self.Targets.Free;
  end;

  procedure TTargetIntegrator.Run(var Target: TTarget; t0: real; tk: real);
  var i: integer; dt, time: real;
  begin
    dt := (tK - T0)/self.num;
    time := t0;
    while time < TK do begin
      CalcTarget(Target, time, dt);
      Target.Time := Target.Time + Target.CalcTime(time)*dt;
      time := time + dt;
    end;//while end
  end;//procedure end

  procedure TTargetIntegrator.CalcTarget(var Target: TTarget; Time: Real; Dt: Real);
  begin
    if Target.TargetType = Air then
      with Target as TAircraft do begin
        Target.MoveParam.mFuel := Target.MoveParam.mFuel - Target.CalcMFuel(time)*dt;
        Target.ResistParam.X := Target.CalcResist(time);
        Target.MoveParam.P := Target.CalcP(time);
        Target.V := Target.V + Target.CalcV(time)*dt;
        Target.CurPosition.x := Target.CurPosition.x + Target.CalcX(time)*dt;
        Target.CurPosition.y := Target.CurPosition.y + Target.CalcY(time)*dt;
      end//with end

    else
      with Target as TMissile do begin
        Target.MoveParam.mFuel := Target.MoveParam.mFuel - Target.CalcMFuel(time)*dt;
        Target.ResistParam.X := Target.CalcResist(time);
        Target.MoveParam.P := Target.CalcP(time);
        Target.V := Target.V + Target.CalcV(time)*dt;
        Target.CurPosition.x := Target.CurPosition.x + Target.CalcX(time)*dt;
        Target.CurPosition.y := Target.CurPosition.y + Target.CalcY(time)*dt;
      end;//with end
  end;
end.
