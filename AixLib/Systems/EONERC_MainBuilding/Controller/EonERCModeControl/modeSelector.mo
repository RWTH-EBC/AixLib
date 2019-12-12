within AixLib.Systems.EONERC_MainBuilding.Controller.EonERCModeControl;
model modeSelector "Selects sub modes for heating and cooling"
  Modelica.Blocks.Interfaces.RealInput T_HS[2]
    "Connector of Real input signals" annotation (Placement(transformation(
          extent={{-140,40},{-100,80}}), iconTransformation(extent={{-136,42},{-100,
            78}})));
  Modelica.Blocks.Interfaces.RealInput T_CS[2]
    "Connector of Real input signals" annotation (Placement(transformation(
          extent={{-140,-80},{-100,-40}}), iconTransformation(extent={{-136,-78},
            {-100,-42}})));

  Modelica.Blocks.Interfaces.IntegerOutput modeSWU annotation (Placement(
        transformation(extent={{100,-90},{120,-70}}),iconTransformation(extent={{100,-90},
            {120,-70}})));
  Modelica.Blocks.Interfaces.RealInput T_air "Connector of Real input signals"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-40,-120}), iconTransformation(extent={{-18,-18},{18,18}},
        rotation=90,
        origin={40,-118})));
  Modelica.Blocks.Interfaces.RealInput T_geo "Connector of Real input signals"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={40,-120}), iconTransformation(extent={{-18,-18},{18,18}},
        rotation=90,
        origin={-40,-118})));
  Modelica.Blocks.Interfaces.BooleanOutput useHP
    "Connector of Boolean output signal" annotation (Placement(transformation(
          extent={{100,70},{120,90}}), iconTransformation(extent={{100,70},{120,
            90}})));
  Modelica.Blocks.Interfaces.BooleanOutput freeCoolingGC
    "Connector of Boolean output signal" annotation (Placement(transformation(
          extent={{100,30},{120,50}}), iconTransformation(extent={{100,-10},{120,
            10}})));
  Modelica.Blocks.Interfaces.BooleanOutput reCoolingGC
    "Connector of Boolean output signal" annotation (Placement(transformation(
          extent={{100,-10},{120,10}}), iconTransformation(extent={{100,30},{
            120,50}})));
  Modelica.Blocks.Interfaces.BooleanOutput useGTF
    "Connector of Boolean output signal" annotation (Placement(transformation(
          extent={{100,-50},{120,-30}}),
                                       iconTransformation(extent={{100,-50},{120,
            -30}})));
  Integer case "Operation case according to Fuetterer for debugging";

  Modelica.Blocks.Interfaces.BooleanOutput heatingMode
    "Connector of Boolean output signal" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={40,110}), iconTransformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,110})));

  Real dT_HS "Energy change of heat storage";
  Real dT_CS "Energy change of cold storage";

  Modelica.Blocks.Interfaces.BooleanInput hpOn
    "Connector of Boolean input signal" annotation (Placement(transformation(
          extent={{-140,-20},{-100,20}}), iconTransformation(extent={{-136,-18},
            {-100,18}})));
  Modelica.Blocks.Math.Mean mean_HS(f=1/600);
  Modelica.Blocks.Math.Mean mean_CS(f=1/600);
equation
//determine heating or cooling mode

  dT_HS = 0.5*der(T_HS[1] + T_HS[2])*4000;
  dT_CS = 0.5*der(T_CS[1] + T_CS[2])*5000;

  if hpOn then
    mean_HS.u = 0;
    mean_CS.u = 0;

  else
    mean_HS.u = dT_HS;
    mean_CS.u = dT_CS;
  end if;

  if dT_HS > dT_CS then
    heatingMode = true;
  else
    heatingMode = false;
  end if;




//heating modes
  //HP only
  if heatingMode and T_CS[1] > 273.15+12 then
    modeSWU = 1;
    useHP = true;
    freeCoolingGC = false;
    reCoolingGC = false;
    useGTF = false;
    case = 1;
  //HP + GTF
  elseif heatingMode and T_CS[1] < 273.15+12 then
    modeSWU = 2;
    useHP = true;
    freeCoolingGC = false;
    reCoolingGC = false;
    useGTF = true;
    case = 2;
//cooling modes
  //free cooling glycol cooler only
  elseif not heatingMode and T_air<10+273.15 and 0.5*(T_HS[1] + T_HS[2])>273.15+31 then
    modeSWU = 4;
    useHP = false;
    freeCoolingGC = true;
    reCoolingGC = false;
    useGTF = false;
    case = 3;
  //all cooling by gtf
  elseif not heatingMode and T_geo<12+273.15 and 0.5*(T_HS[1] + T_HS[2])>273.15+31 then
    modeSWU = 5;
    useHP = false;
    freeCoolingGC = false;
    reCoolingGC = false;
    useGTF = true;
    case = 4;
  //gtf for cca, cooling network by HP
  elseif not heatingMode and T_geo<17+273.15 and 0.5*(T_HS[1] + T_HS[2])>273.15+31 then
    modeSWU = 3;
    useHP = true;
    freeCoolingGC = false;
    reCoolingGC = false;
    useGTF = true;
    case = 5;
    //gtf for cca, cooling network by HP and recooler
  elseif not heatingMode and T_geo<17 + 273.15 and 0.5*(T_HS[1] + T_HS[2])>273.15+33 then
    modeSWU = 3;
    useHP = true;
    freeCoolingGC = false;
    reCoolingGC = true;
    useGTF = true;
    case = 6;
  // cooling network by HP
  elseif not heatingMode and T_geo>17+273.15 and 0.5*(T_HS[1] + T_HS[2])<273.15+33 then
    modeSWU = 4;
    useHP = true;
    freeCoolingGC = false;
    reCoolingGC = false;
    useGTF = false;
    case = 7;
  elseif not heatingMode and T_geo>17+273.15 and 0.5*(T_HS[1] + T_HS[2])>273.15+33 then
    modeSWU = 4;
    useHP = true;
    freeCoolingGC = false;
    reCoolingGC = true;
    useGTF = false;
    case = 8;
  else
    modeSWU = 4;
    useHP = true;
    freeCoolingGC = false;
    reCoolingGC = false;
    useGTF = false;
    case = 0;
  end if;


  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end modeSelector;
