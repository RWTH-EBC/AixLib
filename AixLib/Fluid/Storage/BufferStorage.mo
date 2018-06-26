within AixLib.Fluid.Storage;
model BufferStorage
  "Buffer Storage Model with support for heating rod and two heating coils"
  import SI = Modelica.SIunits;

  replaceable package Medium =
      Modelica.Media.Interfaces.PartialMedium "Medium model"
                 annotation (Dialog(group="Medium"),choicesAllMatching = true);

  replaceable package MediumHC1 =
      Modelica.Media.Interfaces.PartialMedium "Medium model for HC1"
                 annotation (choicesAllMatching = true, Dialog(group="Medium"));

  replaceable package MediumHC2 =
      Modelica.Media.Interfaces.PartialMedium "Medium model for HC2"
                 annotation (choicesAllMatching = true, Dialog(group="Medium"));

  parameter Boolean useHeatingCoil1=true "Use Heating Coil1?" annotation(Dialog(tab="Heating Coils and Rod"));
  parameter Boolean useHeatingCoil2=true "Use Heating Coil2?" annotation(Dialog(tab="Heating Coils and Rod"));
  parameter Boolean useHeatingRod=true "Use Heating Rod?" annotation(Dialog(tab="Heating Coils and Rod"));

  parameter SI.Temperature TStart=298.15 "Start Temperature of fluid" annotation (Dialog(tab="Initialisation"));

  parameter AixLib.DataBase.Storage.BufferStorageBaseDataDefinition data=
    AixLib.DataBase.Storage.Generic_New_2000l()
    "Data record for Storage"
  annotation (choicesAllMatching);

  parameter Integer n(min=3)=5 " Model assumptions Number of Layers";

////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////CONVECTION/////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////

  parameter Modelica.SIunits.CoefficientOfHeatTransfer alphaInside=100
    "Model assumptions Coefficient of Heat Transfer water <-> wall";
  parameter Modelica.SIunits.CoefficientOfHeatTransfer alphaOutside=10
    "Model assumptions Coefficient of Heat Transfer insulation <-> air";
  parameter Modelica.SIunits.CoefficientOfHeatTransfer alphaHC1=100
    "Model assumptions Coefficient of Heat Transfer HC1 <-> Heating Water" annotation(Dialog(enable = useHeatingCoil1,tab="Heating Coils and Rod"));
  parameter Modelica.SIunits.CoefficientOfHeatTransfer alphaHC2=100
    " Model assumptions Coefficient of Heat Transfer HC2 <-> Heating Water" annotation(Dialog(enable = useHeatingCoil2,tab="Heating Coils and Rod"));
  parameter Boolean upToDownHC1 = true
    "Heating Coil 1 orientation from up to down?"
                                                 annotation(Dialog(enable = useHeatingCoil1,tab="Heating Coils and Rod"));
  parameter Boolean upToDownHC2 = true
    "Heating Coil 2 orientation from up to down?"
                                                 annotation(Dialog(enable = useHeatingCoil2,tab="Heating Coils and Rod"));

  parameter Modelica.SIunits.Temperature TStartWall=293.15
    "Starting Temperature of wall in K" annotation(Dialog(tab="Initialisation"));
  parameter Modelica.SIunits.Temperature TStartIns=293.15
    "Starting Temperature of insulation in K" annotation(Dialog(tab="Initialisation"));

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////final parameters////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
 final parameter Integer nHC1Up=integer(ceil(data.hHC1Up/(data.hTank/n)));
 final parameter Integer nHC1Low=integer(floor(data.hHC1Low/(data.hTank/n))+1);
 final parameter Integer disHC1 = nHC1Up-nHC1Low+1;

 final parameter Integer nHC2Up=integer(ceil(data.hHC2Up/(data.hTank/n)));
 final parameter Integer nHC2Low=integer(floor(data.hHC2Low/(data.hTank/n))+1);
 final parameter Integer disHC2 = nHC2Up-nHC2Low+1;

 final parameter Integer nHR=integer(AixLib.Utilities.Math.Functions.round(data.hHR/(data.hTank/n) + 0.5,0));

 final parameter Integer nTS1=integer(AixLib.Utilities.Math.Functions.round(data.hTS1/(data.hTank/n) + 0.5,0));
 final parameter Integer nTS2=integer(AixLib.Utilities.Math.Functions.round(data.hTS2/(data.hTank/n) + 0.5,0));

 final parameter Integer nLowerPorts=integer(max(AixLib.Utilities.Math.Functions.round(data.hLowerPorts/(data.hTank/n) + 0.5,0),1));
 final parameter Integer nUpperPorts=integer(min(AixLib.Utilities.Math.Functions.round(data.hUpperPorts/(data.hTank/n) + 0.5,0),n));
 final parameter Boolean inpLowLay=(nLowerPorts == 1); //if there is an input at the lowest layer
 final parameter Boolean inpHigLay=(nUpperPorts == n);

 final parameter Integer[n] inpActLay = cat(1,{if (nLowerPorts==k) then (if (nUpperPorts==k) then 2 else 1) else (if (nUpperPorts==k) then 1 else 0) for k in 1:n});
 final parameter Integer[n] portsLayer=cat(1,{if inpActLay[1]==1 then 3 else 1},{inpActLay[k]*2+2 for k in 2:n-1},{if inpActLay[n]==1 then 3 else 1});
////////////////////////////////////////////////////////////////////////////////////////////////////
///////////components/////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatportOutside "Outer heat port"
    annotation (Placement(transformation(extent={{68,-4},{88,16}},rotation=0),
        iconTransformation(extent={{68,-4},{88,16}})));
  Modelica.Blocks.Interfaces.RealOutput TTop(
      final quantity="ThermodynamicTemperature",
      final unit = "K",
      min=0,
      displayUnit = "degC")
    "Temperature at the top"
    annotation (Placement(transformation(
        origin={-77,81},
        extent={{-5,5},{5,-5}},
        rotation=0),  iconTransformation(
        extent={{-5,5},{5,-5}},
        rotation=0,
        origin={-80,88})));
  Modelica.Blocks.Interfaces.RealOutput TBottom(
      final quantity="ThermodynamicTemperature",
      final unit = "K",
      min=0,
      displayUnit = "degC")
    "Temperature at the Bottom"
    annotation (Placement(transformation(
        origin={-77,-77},
        extent={{-5,5},{5,-5}},
        rotation=0),   iconTransformation(
        extent={{-5,5},{5,-5}},
        rotation=0,
        origin={-80,-80})));
  Modelica.Fluid.Interfaces.FluidPort_a fluidportTop1(  redeclare final package
              Medium =
                Medium)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-38,92},{-18,110}},rotation=
           0), iconTransformation(extent={{-38,92},{-18,110}})));
  Modelica.Fluid.Interfaces.FluidPort_a fluidportBottom2(redeclare final
      package Medium =
               Medium)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{14,-110},{32,-92}},rotation=
           0), iconTransformation(extent={{14,-110},{32,-92}})));
  Modelica.Fluid.Interfaces.FluidPort_b fluidportBottom1(  redeclare final
      package Medium =
                 Medium)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-36,-112},{-18,-92}},
          rotation=0), iconTransformation(extent={{-36,-112},{-18,-92}})));
  Modelica.Fluid.Interfaces.FluidPort_b fluidportTop2(redeclare final package
      Medium =
        Medium)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{14,92},{36,110}},rotation=0),
        iconTransformation(extent={{14,92},{36,110}})));

  HeatTransfer heatTransfer(final n=n,
      redeclare final package Medium = Medium, 
      final data=data) 
      "Heat transfer model" annotation (Placement(transformation(extent={{-34,0},
            {-14,20}}, rotation=0)));

  AixLib.Fluid.MixingVolumes.MixingVolume          layer[n](
    final V=fill(data.hTank/n*Modelica.Constants.pi/4*data.dTank^2,n),
    final nPorts = portsLayer,
    final T_start=fill(TStart,n),
    redeclare each final package Medium = Medium,
    each m_flow_nominal=0.05)
    "Layer volumes"
    annotation (Placement(transformation(extent={{-6,0},{14,20}})));
    replaceable model HeatTransfer =
      AixLib.Fluid.Storage.BaseClasses.HeatTransferOnlyConduction
    constrainedby AixLib.Fluid.Storage.BaseClasses.PartialHeatTransferLayers
    "Heat Transfer Model between fluid layers" annotation (choicesAllMatching=
        true);

///////////////////////////////////////////////////////////////////////////////////////
/////HEATING COILS AND RODS/////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////////////
/////HEATING COIL 1 ////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////

  Modelica.Fluid.Interfaces.FluidPort_a portHC1In(redeclare final package Medium =
        MediumHC1) if useHeatingCoil1
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-92,36},{-72,56}}),
        iconTransformation(extent={{-90,50},{-74,64}})));
  Modelica.Fluid.Interfaces.FluidPort_b portHC1Out(redeclare final package Medium =
        MediumHC1) if useHeatingCoil1
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-90,2},{-70,22}}),
        iconTransformation(extent={{-88,20},{-74,32}})));

//////////////////////////////////////////////////////////////////////////////////////////
/////HEATING COIL 2 ////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////

  Modelica.Fluid.Interfaces.FluidPort_a portHC2In(redeclare final package Medium =
        MediumHC2) if useHeatingCoil2
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-92,-30},{-72,-10}}),
        iconTransformation(extent={{-88,-32},{-74,-18}})));
  Modelica.Fluid.Interfaces.FluidPort_b portHC2Out(redeclare final package Medium =
        MediumHC2) if useHeatingCoil2
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-92,-68},{-72,-48}}),
        iconTransformation(extent={{-88,-64},{-74,-50}})));

//////////////////////////////////////////////////////////////////////////////////////////
/////HEATING ROD ////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatingRod if
                                          useHeatingRod annotation (
      Placement(transformation(extent={{-86,-6},{-74,6}}, rotation=0)));

//////////////////////////////////////////////////////////////////////////////////////////
/////COVER / INSULATION  ////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////

  AixLib.Fluid.Storage.BaseClasses.StorageCover topCover(
    lambdaWall=data.lambdaWall,
    lambdaIns=data.lambdaIns,
    alphaInside=alphaInside,
    alphaOutside=alphaOutside,
    TStartWall=TStartWall,
    TStartIns=TStartIns,
    rhoIns=data.rhoIns,
    cIns=data.cIns,
    rhoWall=data.rhoWall,
    cWall=data.cWall,
    D1=data.dTank,
    sWall=data.sWall,
    sIns=data.sIns) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={8,56})));
  AixLib.Fluid.Storage.BaseClasses.StorageMantle storageMantle[n](
    each lambdaWall=data.lambdaWall,
    each lambdaIns=data.lambdaIns,
    each TStartWall=TStartWall,
    each TStartIns=TStartIns,
    each rhoIns=data.rhoIns,
    each cIns=data.cIns,
    each rhoWall=data.rhoWall,
    each cWall=data.cWall,
    each height=data.hTank/n,
    each D1=data.dTank,
    each sWall=data.sWall,
    each sIns=data.sIns,
    each alphaInside=alphaInside,
    each alphaOutside=alphaOutside)
    annotation (Placement(transformation(extent={{20,-2},{40,18}})));
  AixLib.Fluid.Storage.BaseClasses.StorageCover bottomCover(
    lambdaWall=data.lambdaWall,
    lambdaIns=data.lambdaIns,
    alphaInside=alphaInside,
    alphaOutside=alphaOutside,
    TStartWall=TStartWall,
    TStartIns=TStartIns,
    rhoIns=data.rhoIns,
    cIns=data.cIns,
    rhoWall=data.rhoWall,
    cWall=data.cWall,
    D1=data.dTank,
    sWall=data.sWall,
    sIns=data.sIns) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={6,-44})));

  AixLib.Fluid.Storage.BaseClasses.HeatingCoil heatingCoil1(
    disHC=disHC1,
    alphaHC=alphaHC1,
    redeclare package Medium = MediumHC1,
    lengthHC=data.lengthHC1,
    pipeHC=data.pipeHC1,
    allowFlowReversal=true,
    m_flow_nominal=0.05,
    TStart=TStart) if         useHeatingCoil1 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-58,29})));
  AixLib.Fluid.Storage.BaseClasses.HeatingCoil heatingCoil2(
    disHC=disHC2,
    lengthHC=data.lengthHC2,
    alphaHC=alphaHC2,
    pipeHC=data.pipeHC2,
    redeclare package Medium = MediumHC2,
    allowFlowReversal=true,
    m_flow_nominal=0.05,
    TStart=TStart) if                        useHeatingCoil2 annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-56,-39})));

initial equation
   assert(data.hHC1Up<=data.hTank and data.hHC1Up>=0.0 and
     data.hHC1Low<=data.hTank and data.hHC1Low>=0.0,
     "Storage coil 1 inlet and outlet must be within tank's height.",
     level = AssertionLevel.error);
   assert(data.hHC1Up>data.hHC1Low,
     "Storage coil 1 upper port must be higher than lower port.",
     level = AssertionLevel.error);

   assert(data.hHC2Up<=data.hTank and data.hHC2Up>=0.0 and
     data.hHC2Low<=data.hTank and data.hHC2Low>=0.0,
     "Storage coil 2 inlet and outlet must be within tank's height.",
     level = AssertionLevel.error);
   assert(data.hHC2Up>data.hHC2Low,
     "Storage coil 2 upper port must be higher than lower port.",
     level = AssertionLevel.error);

equation
////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////connection of Heating Coils//////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
 if useHeatingCoil1 then

 for i in nHC1Low:nHC1Up loop

   if upToDownHC1 == true then
     connect(heatingCoil1.Therm1[nHC1Up+1-i], layer[i].heatPort);
   else
     connect(heatingCoil1.Therm1[i-nHC1Low+1], layer[i].heatPort);
 end if;

end for;

connect(portHC1In, heatingCoil1.port_a) annotation (Line(
      points={{-82,46},{-58,46},{-58,39}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(portHC1Out, heatingCoil1.port_b) annotation (Line(
      points={{-80,12},{-59,12},{-59,19},{-58,19}},
      color={0,127,255},
      smooth=Smooth.None));

end if;

 if useHeatingCoil2 then

 for i in nHC2Low:nHC2Up loop

   if upToDownHC2 == true then
     connect(heatingCoil2.Therm1[nHC2Up+1-i], layer[i].heatPort);
   else
     connect(heatingCoil2.Therm1[i-nHC2Low+1], layer[i].heatPort);
   end if;
   end for;

  connect(portHC2In, heatingCoil2.port_a) annotation (Line(
      points={{-82,-20},{-55,-20},{-55,-29},{-56,-29}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(portHC2Out, heatingCoil2.port_b) annotation (Line(
      points={{-82,-58},{-56,-58},{-56,-49}},
      color={0,127,255},
      smooth=Smooth.None));

 end if;

////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////connection of Heating Rod//////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////

if useHeatingRod then

connect(heatingRod, layer[nHR].heatPort);
end if;

////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////  connection of Temperature Sensor///////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
  if nTS1 <= 1 then
    TBottom = layer[1].heatPort.T;
  elseif nTS1 >= n then
    TBottom = layer[n].heatPort.T;
  else
    TBottom = layer[nTS1].heatPort.T;
  end if;
  if nTS2 <= 1 then
    TTop = layer[1].heatPort.T;
  elseif nTS2 >= n then
    TTop = layer[n].heatPort.T;
  else
    TTop = layer[nTS2].heatPort.T;
  end if;
////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////connection of volumes and walls//////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
   for i in 1:n loop
     connect(layer[i].heatPort, storageMantle[i].heatportInner);
     connect(storageMantle[i].heatportOuter, heatportOutside);
   end for;
    connect(layer[1].heatPort, bottomCover.heatportInner);
    connect(layer[n].heatPort,topCover.heatportInner);

    connect(bottomCover.heatportOuter, heatportOutside);
    connect(topCover.heatportOuter, heatportOutside);

////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////connections of inner layers//////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
  for i in 2:(n-1) loop
    if nLowerPorts == i then
       connect(layer[i].ports[3], fluidportBottom1);
       connect(layer[i].ports[4], fluidportBottom2);
       if nUpperPorts == i then
         connect(layer[i].ports[5],fluidportTop1);
         connect(layer[i].ports[6],fluidportTop2);
       end if;
    elseif nUpperPorts ==i then
         connect(layer[i].ports[3],fluidportTop1);
         connect(layer[i].ports[4],fluidportTop2);
    end if;

   connect(layer[i].ports[2],layer[i+1].ports[1]);
  end for;
////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////connections of upper and lower layer/////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
  if nLowerPorts == 1 then
    connect(layer[1].ports[2],fluidportBottom1);
    connect(layer[1].ports[3],fluidportBottom2);
  end if;
  connect(layer[1].ports[1],layer[2].ports[1]);

  if nUpperPorts == n then
    connect(layer[n].ports[2],fluidportTop1);
    connect(layer[n].ports[3],fluidportTop2);
  end if;

////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////connections of heat transfer model///////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
  connect(heatTransfer.therm, layer.heatPort);

  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-80,-100},
            {80,100}}), graphics={
        Rectangle(
          extent={{-80,-71},{80,71}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={85,170,255},
          fillPattern=FillPattern.Solid,
          origin={0,-29},
          rotation=360),
        Polygon(
          points={{-24,-3},{-20,-9},{-10,-9},{6,-9},{18,-11},{38,-19},{68,-19},{
              106,-15},{136,1},{136,39},{-24,35},{-24,-3}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          smooth=Smooth.None,
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid,
          origin={-56,19},
          rotation=360),
        Polygon(
          points={{-39,-4},{-31,-18},{-11,-28},{25,-34},{67,-32},{93,-28},{121,-8},
              {121,24},{-39,26},{-39,-4}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          smooth=Smooth.None,
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid,
          origin={-41,60},
          rotation=360),
        Polygon(
          points={{-80,100},{-80,78},{-62,62},{-32,58},{30,62},{62,72},{80,82},{
              80,100},{-80,100}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          smooth=Smooth.None,
          fillColor={255,62,62},
          fillPattern=FillPattern.Solid,
          origin={0,0},
          rotation=360),
        Polygon(
          points={{-154,3},{-134,-3},{-110,1},{-84,-1},{-56,-5},{-30,-11},{6,-3},
              {6,-41},{-154,-41},{-154,3}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          smooth=Smooth.None,
          fillColor={14,110,255},
          fillPattern=FillPattern.Solid,
          origin={74,-27},
          rotation=360),
        Polygon(
          points={{-154,3},{-136,-7},{-110,-3},{-84,-7},{-48,-5},{-18,-9},{6,-3},
              {6,-41},{-154,-41},{-154,3}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          smooth=Smooth.None,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          origin={74,-59},
          rotation=360),
        Line(
          points={{0,9},{0,-9}},
          color={0,0,0},
          smooth=Smooth.Bezier,
          thickness=1,
          arrow={Arrow.Filled,Arrow.None},
          origin={-28,83},
          rotation=180,
          visible = true),
        Line(
          points={{0,9},{0,-9}},
          color={0,0,0},
          smooth=Smooth.Bezier,
          thickness=1,
          arrow={Arrow.Filled,Arrow.None},
          origin={26,83},
          rotation=360,
          visible = true),
        Line(
          points={{0,9},{0,-9}},
          color={0,0,0},
          smooth=Smooth.Bezier,
          thickness=1,
          arrow={Arrow.Filled,Arrow.None},
          origin={-26,-83},
          rotation=180,
          visible = true),
        Line(
          points={{0,9},{0,-9}},
          color={0,0,0},
          smooth=Smooth.Bezier,
          thickness=1,
          arrow={Arrow.Filled,Arrow.None},
          origin={24,-83},
          rotation=360,
          visible = true),
        Line(
          points={{0,9},{0,-9}},
          color={0,0,0},
          smooth=Smooth.Bezier,
          thickness=1,
          arrow={Arrow.Filled,Arrow.None},
          origin={-66,57},
          rotation=270,
          visible=useHeatingCoil1),
        Line(
          points={{0,9},{0,-9}},
          color={0,0,0},
          smooth=Smooth.Bezier,
          thickness=1,
          arrow={Arrow.Filled,Arrow.None},
          origin={-66,25},
          rotation=90,
          visible = useHeatingCoil1),
        Rectangle(
          extent={{-80,100},{80,-100}},
          lineColor={0,0,0},
          lineThickness=1),
        Line(
          points={{-46,57},{56,57}},
          color={0,0,0},
          thickness=1,
          smooth=Smooth.Bezier,
          visible = useHeatingCoil1),
        Line(
          points={{-46,25},{56,25}},
          color={0,0,0},
          thickness=1,
          smooth=Smooth.Bezier,
          visible = useHeatingCoil1),
        Line(
          points={{-46,50},{56,57}},
          color={0,0,0},
          thickness=1,
          smooth=Smooth.Bezier,
          visible = useHeatingCoil1),
        Line(
          points={{56,42},{-46,50}},
          color={0,0,0},
          thickness=1,
          smooth=Smooth.Bezier,
          visible = useHeatingCoil1),
        Line(
          points={{-46,34},{56,42}},
          color={0,0,0},
          thickness=1,
          smooth=Smooth.Bezier,
          visible = useHeatingCoil1),
        Line(
          points={{56,26},{-46,34}},
          color={0,0,0},
          thickness=1,
          smooth=Smooth.Bezier,
          visible = useHeatingCoil1),
        Line(
          points={{-57,25},{-46,58}},
          color={0,0,0},
          thickness=1,
          smooth=Smooth.Bezier,
          arrow={Arrow.Filled,Arrow.None},
          visible = (useHeatingCoil1 and not
                                            (upToDownHC1))),
        Line(
          points={{-57,58},{-46,25}},
          color={0,0,0},
          thickness=1,
          smooth=Smooth.Bezier,
          arrow={Arrow.None,Arrow.Filled},
          visible = (useHeatingCoil1 and not
                                            (upToDownHC1))),
        Line(
          points={{0,9},{0,-9}},
          color={0,0,0},
          smooth=Smooth.Bezier,
          thickness=1,
          origin={-48,57},
          rotation=270,
          visible = (useHeatingCoil1 and upToDownHC1)),
        Line(
          points={{0,9},{0,-9}},
          color={0,0,0},
          smooth=Smooth.Bezier,
          thickness=1,
          origin={-50,25},
          rotation=270,
          visible = (useHeatingCoil1 and upToDownHC1)),
        Line(
          points={{0,9},{0,-9}},
          color={0,0,0},
          smooth=Smooth.Bezier,
          thickness=1,
          arrow={Arrow.Filled,Arrow.None},
          origin={-66,-25},
          rotation=270,
          visible=useHeatingCoil2),
        Line(
          points={{-46,-25},{56,-25}},
          color={0,0,0},
          thickness=1,
          smooth=Smooth.Bezier,
          visible = useHeatingCoil2),
        Line(
          points={{-46,-32},{56,-25}},
          color={0,0,0},
          thickness=1,
          smooth=Smooth.Bezier,
          visible = useHeatingCoil2),
        Line(
          points={{56,-40},{-46,-32}},
          color={0,0,0},
          thickness=1,
          smooth=Smooth.Bezier,
          visible = useHeatingCoil2),
        Line(
          points={{-46,-48},{56,-40}},
          color={0,0,0},
          thickness=1,
          smooth=Smooth.Bezier,
          visible = useHeatingCoil2),
        Line(
          points={{56,-56},{-46,-48}},
          color={0,0,0},
          thickness=1,
          smooth=Smooth.Bezier,
          visible = useHeatingCoil2),
        Line(
          points={{-46,-57},{56,-57}},
          color={0,0,0},
          thickness=1,
          smooth=Smooth.Bezier,
          visible = useHeatingCoil2),
        Line(
          points={{0,9},{0,-9}},
          color={0,0,0},
          smooth=Smooth.Bezier,
          thickness=1,
          origin={-50,-57},
          rotation=270,
          visible = (useHeatingCoil2 and upToDownHC2)),
        Line(
          points={{0,9},{0,-9}},
          color={0,0,0},
          smooth=Smooth.Bezier,
          thickness=1,
          arrow={Arrow.Filled,Arrow.None},
          origin={-66,-57},
          rotation=90,
          visible = useHeatingCoil2),
        Line(
          points={{0,9},{0,-9}},
          color={0,0,0},
          smooth=Smooth.Bezier,
          thickness=1,
          origin={-48,-25},
          rotation=270,
          visible = (useHeatingCoil2 and upToDownHC2)),
        Line(
          points={{-57,-24},{-46,-57}},
          color={0,0,0},
          thickness=1,
          smooth=Smooth.Bezier,
          arrow={Arrow.None,Arrow.Filled},
          visible = (useHeatingCoil2 and not
                                            (upToDownHC2))),
        Line(
          points={{-57,-57},{-46,-24}},
          color={0,0,0},
          thickness=1,
          smooth=Smooth.Bezier,
          arrow={Arrow.Filled,Arrow.None},
          visible = (useHeatingCoil2 and not
                                            (upToDownHC2))),
        Line(
          points={{-76,-1},{26,-1}},
          color={0,0,0},
          smooth=Smooth.Bezier,
          visible = useHeatingRod,
          thickness=2)}),
                 Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-80,-100},{80,100}})),
    Documentation(revisions="<html>
<ul>
<li><i>October 12, 2016&nbsp;</i> by Marcus Fuchs:<br/>Add comments and fix documentation</li>
<li><i>October 11, 2016&nbsp;</i> by Sebastian Stinner:<br/>Added to AixLib</li>
<li><i>March 25, 2015&nbsp;</i> by Ana Constantin:<br/>Uses components from MSL</li>
<li><i>December 10, 2013</i> by Kristian Huchtemann:<br/>Added documentation of storage and new heat transfer models.</li>
<li><i>October 2, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
<li><i>February 19, 2013 </i>by Sebastian Stinner: <br/>mistake in losses calculation corrected (thickness of &quot;wall&quot; and &quot;insulation&quot; was only considered once but has to be considered twice, additionally the components &quot;wall&quot; and &quot;insulation&quot; were exchanged )<br/>and mistake in bouyancy model &quot;Wetter&quot; corrected (bouyancy flows were flowing in the wrong direction)</li>
</ul>
</html>",
        info="<html>
<h4><span style=\"color: #008000\">Overview</span></h4>
<p>Buffer Storage Model with support for heating rod and two heating coils. </p>
<h4><span style=\"color: #008000\">Concept</span></h4>
<p>It represents a buffer storage stratified into n layers where 1 represents
the bottom layer and n represents the top layer. The layers are connected to
each other allowing heat and fluid transfer.The heat transfer between the layers
can be selected to model the conductance between the layers or different models
that additionally represent the buoyancy:</p>
<p><b>HeatTransferOnlyConduction</b>: Model for heat transfer between buffer
storage layers. Models conductance of water. An effective heat conductivity is
therefore calculated. Used in BufferStorage model.</p>
<p><b>HeatTransferLambdaSimple: </b>Model for heat transfer between buffer
storage layers. Models conductance of water and additional effective
conductivity (in case the above layer is colder than the lower layer). Used in
BufferStorage model.</p>
<p><b>HeatTransferLambdaEff: </b>Model for heat transfer between buffer storage
layers. Models conductance of water and buoyancy according to Viskanta et al.,
1997. An effective heat conductivity is therefore calculated. Used in
BufferStorage model.</p>
<p><b>HeatTransferLambdaEffSmooth: </b>Same as HeatTransfer_lambda_eff. In
addition, the <i>smooth()</i> expression is used for the transition of the
buoyancy model.</p>
<p><b>HeatTransferLambdaEffTanh: </b>Same as HeatTransfer_lambda_eff. In
addition, a tanh function is used for the transition of the buoyancy model
(VariableTransition model). Attention: the initial value of the FullTransition
model is 0.5. This may lead to a mixture of the storage at the beginning of the
simulation.</p>
<p><b>HeatTransferBuoyancyWetter: </b>Model for heat transfer between buffer
storage layers. Models buoyancy according to
Buildings.Fluid.Storage.BaseClasses.Buoyancy model of Buildings library, cf.
https://simulationresearch.lbl.gov/modelica. No conduction is implemented apart
from when buoyancy occurs.</p> <p>The geometrical data for the storage is read
by records in the DataBase package. The model also includes heat losses over the
storage walls (wall, top and bottom). No pressure losses are included. Thus
external pressure loss models are required for the use of the model. </p>
<h4><span style=\"color: #008000\">Sources</span></h4>
<ul>
<li>R. Viskanta, A. KaraIds: Interferometric observations of the temperature
structure in water cooled or heated from above. <i>Advances in Water
Resources,</i> volume 1, 1977, pages 57-69. Bibtex-Key [R.VISKANTA1977]</li>
</ul>
<h4><span style=\"color: #008000;\">Example Results</span></h4>
<p><a href=\"AixLib.Fluid.Storage.Examples.BufferStorageCharging\">AixLib.Fluid.Storage.Examples.BufferStorageCharging</a></p>
</html>"));
end BufferStorage;
