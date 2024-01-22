within AixLib.Obsolete.YearIndependent.FastHVAC.Components.Storage;
model StorageSimpleWall
  extends AixLib.Obsolete.BaseClasses.ObsoleteModel;

  /* *******************************************************************
      Medium
     ******************************************************************* */
public
  parameter FastHVAC.Media.BaseClasses.MediumSimple medium=
      FastHVAC.Media.WaterSimple()
    "Mediums charastics (heat capacity, density, thermal conductivity)"
    annotation (Dialog(group="Medium"), choicesAllMatching);

    parameter FastHVAC.Media.BaseClasses.MediumSimple mediumHC1=
      FastHVAC.Media.WaterSimple()
    "Mediums charastics for HC1 (heat capacity, density, thermal conductivity)"
    annotation (Dialog(group="Medium"), choicesAllMatching);

     parameter FastHVAC.Media.BaseClasses.MediumSimple mediumHC2=
      FastHVAC.Media.WaterSimple()
    "Mediums charastics HC2 (heat capacity, density, thermal conductivity)"
    annotation (Dialog(group="Medium"), choicesAllMatching);

  parameter Modelica.Units.SI.Temperature T_start=323.15
    "Start temperature of medium";

  /* *******************************************************************
      HeatStorage Parameters
     ******************************************************************* */
  parameter Integer n(min=3) = 5 "Model assumptions Number of Layers";

  parameter Modelica.Units.SI.CoefficientOfHeatTransfer hConIn=1500
    "Heat transfer coefficient at the inner wall";
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer hConOut=15
    "Heat transfer coefficient at the outer wall";
  inner parameter AixLib.DataBase.Storage.BufferStorageBaseDataDefinition data=
      AixLib.DataBase.Storage.Generic_New_2000l() "Storage data"
    annotation (choicesAllMatching);
  parameter Integer[n_load_cycles, 2] load_cycles= {{n,1},{n,1}}
    "Loading cycle connection pairs (upper position first)"
    annotation (Dialog(tab="Connections"));
  parameter Integer[n_unload_cycles, 2] unload_cycles = {{1,n},{1,n}}
    "Unloading cycle connection pairs (lower position first)"
    annotation (Dialog(tab="Connections"));

  Modelica.Units.SI.Energy Heat_loss;
  parameter Integer n_load_cycles=2 "Number of loading cycle connection pairs"
    annotation (Dialog(tab="Connections"));
   parameter Integer n_unload_cycles=2
    "Number of loading cycle connection pairs"
     annotation (Dialog(tab="Connections"));

  /* ***************Heating Coil Section********************************/

  parameter Boolean use_heatingCoil1=true "Use Heating Coil1?" annotation(Dialog(tab="Heating Coils and Rod"));
  parameter Boolean use_heatingCoil2=true "Use Heating Coil2?" annotation(Dialog(tab="Heating Coils and Rod"));
  parameter Boolean use_heatingRod=true "Use Heating Rod?" annotation(Dialog(tab="Heating Coils and Rod"));
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer hConHC1=20
    "Model assumptions heat transfer coefficient HC1 <-> Heating Water"
    annotation (Dialog(enable=use_heatingCoil1, tab="Heating Coils and Rod"));
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer hConHC2=400
    "Model assumptions heat transfer coefficient HC2 <-> Heating Water"
    annotation (Dialog(enable=use_heatingCoil2, tab="Heating Coils and Rod"));
  parameter Boolean Up_to_down_HC1 = true
    "Heating Coil 1 orientation from up to down?"
                                                 annotation(Dialog(enable = use_heatingCoil1,tab="Heating Coils and Rod"));
  parameter Boolean Up_to_down_HC2 = true
    "Heating Coil 2 orientation from up to down?"
                                                 annotation(Dialog(enable = use_heatingCoil2,tab="Heating Coils and Rod"));
  parameter Boolean calcHCon=true "Use calculated value for inside heat transfer coefficient"
                                                      annotation(Dialog(tab="Heating Coils and Rod"));
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer hConIn_const=30
    "Fix value for heat transfer coefficient inside pipe"
    annotation (Dialog(enable=not calcHCon, tab="Heating Coils and Rod"));
//   parameter Modelica.SIunits.Length d_HC1=0.02 "Inner diameter of HC1"
//                             annotation(Dialog(enable = use_heatingCoil1,tab="Heating Coils and Rod"));
//   parameter Modelica.SIunits.Length d_HC2=0.02 "Inner diameter of HC2"
//                             annotation(Dialog(enable = use_heatingCoil2,tab="Heating Coils and Rod"));

  /* *******************************************************************
      Final Parameters
     ******************************************************************* */

 parameter Integer n_HC1_up=n "Highest layer of Heating Coil 1"                                                                      annotation (Dialog(tab="Connections"));
 parameter Integer n_HC1_low=1 "Lowest layer of Heating Coil 1"                                                                       annotation (Dialog(tab="Connections"));
  parameter Integer n_HC2_up=n "Highest layer of Heating Coil 2"                                                                          annotation (Dialog(tab="Connections"));
 parameter Integer n_HC2_low=1 "Lowest layer of Heating Coil 2"                                                                          annotation (Dialog(tab="Connections"));

 parameter Integer n_HR=n "Layer of Heating Rod"                                                                  annotation (Dialog(tab="Connections"));

 final parameter Integer dis_HC1 = n_HC1_up-n_HC1_low+1;
 final parameter Integer dis_HC2 = n_HC2_up-n_HC2_low+1;
  FastHVAC.Interfaces.EnthalpyPort_a LoadingCycle_In[n_load_cycles]
    annotation (Placement(transformation(extent={{-30,90},{-10,110}}),
        iconTransformation(extent={{-30,90},{-10,110}})));
  FastHVAC.Interfaces.EnthalpyPort_b LoadingCycle_Out[n_load_cycles]
    annotation (Placement(transformation(extent={{-30,-110},{-10,-90}}),
        iconTransformation(extent={{-30,-110},{-10,-90}})));
  FastHVAC.Interfaces.EnthalpyPort_b UnloadingCycle_Out[n_unload_cycles]
    annotation (Placement(transformation(extent={{10,90},{30,110}}),
        iconTransformation(extent={{10,90},{30,110}})));
  FastHVAC.Interfaces.EnthalpyPort_a UnloadingCycle_In[n_unload_cycles]
    annotation (Placement(transformation(extent={{10,-110},{30,-90}}),
        iconTransformation(extent={{10,-110},{30,-90}})));

  FastHVAC.BaseClasses.EnergyBalance energyBalance_load[n,n_load_cycles]
    annotation (Placement(transformation(
        extent={{-20,-19},{20,19}},
        rotation=270,
        origin={-59,0})));

  FastHVAC.BaseClasses.EnergyBalance energyBalance_unload[n,
    n_unload_cycles] annotation (Placement(transformation(
        extent={{-20,20},{20,-20}},
        rotation=270,
        origin={60,0})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature varTemp_load[n_load_cycles,2]
    annotation (Placement(transformation(extent={{98,24},{120,44}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow dummy_load[n_load_cycles,2](
      each Q_flow=0)
    annotation (Placement(transformation(extent={{98,44},{118,64}})));

  FastHVAC.Interfaces.EnthalpyPort_a port_HC1_in if use_heatingCoil1
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-110,70},{-90,90}}),
        iconTransformation(extent={{-88,52},{-72,68}})));
  FastHVAC.Interfaces.EnthalpyPort_b port_HC1_out if use_heatingCoil1
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-110,30},{-90,50}}),
        iconTransformation(extent={{-90,12},{-74,28}})));

  FastHVAC.Interfaces.EnthalpyPort_a port_HC2_in if use_heatingCoil2
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-110,-50},{-90,-30}}),
        iconTransformation(extent={{-90,-26},{-76,-12}})));
  FastHVAC.Interfaces.EnthalpyPort_b port_HC2_out if use_heatingCoil2
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-110,-90},{-90,-70}}),
        iconTransformation(extent={{-90,-66},{-76,-52}})));

  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature varTemp_unload[n_unload_cycles,2]
    annotation (Placement(transformation(extent={{98,-56},{120,-36}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow dummy_unload[n_unload_cycles,2](
      each Q_flow=0)
    annotation (Placement(transformation(extent={{98,-36},{118,-16}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatingRod if use_heatingRod annotation (Placement(transformation(
          extent={{-110,90},{-90,110}}),iconTransformation(extent={{-70,70},{-50,
            90}})));
  Modelica.Blocks.Interfaces.RealOutput T_layers[n](  unit="K") annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-110,0}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-90,0})));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a
                           out
    annotation (Placement(transformation(extent={{90,90},{110,110}}),iconTransformation(extent={{50,70},{70,90}})));
  BaseClasses.HeatingCoil heatingCoil1(
    T_start=T_start,
    dis_HC=dis_HC1,
    hConHC=hConHC1,
    medium_HC=mediumHC1,
    lengthHC=data.lengthHC1,
    pipeRecordHC=data.pipeHC1) if use_heatingCoil1
    annotation (Placement(transformation(
        extent={{-15,-12},{15,12}},
        rotation=270,
        origin={-72,59})));
  BaseClasses.HeatingCoil heatingCoil2(
    T_start=T_start,
    dis_HC=dis_HC2,
    hConHC=hConHC2,
    medium_HC=mediumHC2,
    lengthHC=data.lengthHC2,
    pipeRecordHC=data.pipeHC2,
    calcHCon=calcHCon,
    hConIn_const=hConIn_const) if use_heatingCoil2
    annotation (Placement(transformation(
        extent={{-14,-12},{14,12}},
        rotation=270,
        origin={-72,-60})));
//   Modelica.Thermal.HeatTransfer.Components.ThermalConductor heatTransCover[2]
//     annotation (Placement(transformation(extent={{20,-40},{40,-20}})));

HeatTransfer heatTransfer(final Medium=medium,final data=data,
    final n=n) annotation (Placement(transformation(extent={{-10,-10},
            {10,10}},  rotation=0)));

 replaceable model HeatTransfer =
     BaseClasses.HeatTransferOnlyConduction constrainedby
    BaseClasses.PartialHeatTransferLayers
    "Heat Transfer Model between fluid layers" annotation (choicesAllMatching=true);
protected
  parameter Real k_zyl(final unit="W/K") = 2*Modelica.Constants.pi*data.hTank/n/(1/(hConIn*data.dTank/2) + 1/data.lambdaIns*log((data.dTank
    /2 + data.sIns)/(data.dTank/2)) + 1/(hConOut*(data.dTank/2 + data.sIns)));
  parameter Modelica.Units.SI.Area A_cov=data.dTank^2/4*Modelica.Constants.pi
    "Area cop/bottom cover";
  parameter Modelica.Units.SI.Area A_wall=(data.dTank + data.sIns + data.sWall)
      *Modelica.Constants.pi*data.hTank "Area mantle";
    //parameter Real k_cov(final unit="W/(m2.K)") =  {data.lambdaIns/data.sIns*Modelica.Constants.pi*(data.dTank /2)^2 ;

  parameter Real k_wall[n](final unit="W/(m2.K)") = cat(
            1,
            {data.lambdaIns/data.sIns*Modelica.Constants.pi*(data.dTank
      /2)^2 + k_zyl},
            {k_zyl for k in 2:n - 1},
            {data.lambdaIns/data.sIns*Modelica.Constants.pi*(data.dTank
      /2)^2 + k_zyl});

  /* *******************************************************************
      Components
     ******************************************************************* */

  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor layer[n](C=
        fill(data.hTank*Modelica.Constants.pi*(data.dTank/2)^2*medium.rho*medium.c
        /n, n), T(start=fill(T_start, n))) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-30,50})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor
                                                        heatTrans[n]( G=(k_wall))
    annotation (Placement(transformation(extent={{20,38},{40,58}})));
equation
  if use_heatingRod then

connect(heatingRod, layer[n_HR].port);
  end if;

  der(Heat_loss) = out.Q_flow/(1000*3600);

  for k in 1:n loop
    connect(layer[k].port, heatTrans[k].port_a);
    connect(heatTrans[k].port_b, out);
  end for;

  /* ***************Loading Cycles********************************/
  for k in 1:n_load_cycles loop
    //Energy balances are numbered from bottom to top
    connect(LoadingCycle_Out[k], energyBalance_load[1, k].enthalpyPort_b);
    for m in 2:n loop
      connect(energyBalance_load[m - 1, k].enthalpyPort_a, energyBalance_load[m, k].enthalpyPort_b);
    end for;
    connect(LoadingCycle_In[k], energyBalance_load[n, k].enthalpyPort_a);

     for m in 1:n loop
       if m<=load_cycles[k,1] and m>=load_cycles[k,2] then
         connect(energyBalance_load[m, k].heatPort_a,layer[m].port);
       elseif m>load_cycles[k,1] then
         connect(energyBalance_load[m, k].heatPort_a,varTemp_load[k,2].port);
       else
         connect(energyBalance_load[m,k].heatPort_a,varTemp_load[k,1].port);
       end if;
     end for;

  /* *************Setting of the lower temperature********************************/
     if load_cycles[k,2]==1 then
       //just a dummy value, because the dummy varTemp_load is not connected to any energyBalance
       varTemp_load[k,1].T=323.15;
     else
       varTemp_load[k,1].T=layer[load_cycles[k,2]].T;
     end if;

  /* *************Setting of the upper temperature********************************/
     if load_cycles[k,1]==n then
       //just a dummy value, because the dummy varTemp_load is not connected to any energyBalance
       varTemp_load[k,2].T=323.15;
     else
       varTemp_load[k,2].T=LoadingCycle_In[k].T;
     end if;

  end for;

  /* ***************Umloading Cycles********************************/
   for k in 1:n_unload_cycles loop
     //Energy balances are numbered from bottom to top
     connect(UnloadingCycle_In[k], energyBalance_unload[1, k].enthalpyPort_a);
     for m in 2:n loop
       connect(energyBalance_unload[m-1, k].enthalpyPort_b, energyBalance_unload[m, k].enthalpyPort_a);
     end for;
     connect(UnloadingCycle_Out[k], energyBalance_unload[n, k].enthalpyPort_b);

     for m in 1:n loop
       if m>=unload_cycles[k,1] and m<=unload_cycles[k,2] then
         connect(energyBalance_unload[m, k].heatPort_a,layer[m].port);
       elseif m>unload_cycles[k,2] then
         connect(energyBalance_unload[m, k].heatPort_a,varTemp_unload[k,2].port);
       else
         connect(energyBalance_unload[m,k].heatPort_a,varTemp_unload[k,1].port);
       end if;
     end for;

  /* *************Setting of the lower temperature********************************/
     if unload_cycles[k, 1]==1 then
       //just a dummy value, because the dummy varTemp_load is not connected to any energyBalance
       varTemp_unload[k,1].T=323.15;
     else
       varTemp_unload[k,1].T=UnloadingCycle_In[k].T;
     end if;

  /* *************Setting of the upper temperature********************************/
     if unload_cycles[k, 2]==n then
       //just a dummy value, because the dummy varTemp_load is not connected to any energyBalance
       varTemp_unload[k,2].T=323.15;
     else
       varTemp_unload[k,2].T=layer[unload_cycles[k, 2]].T;
     end if;

   end for;

  /* *************Connection Heating Coil********************************/
    if use_heatingCoil1 then

 for i in n_HC1_low:n_HC1_up loop
   if Up_to_down_HC1 == true then
     connect(heatingCoil1.Therm1[n_HC1_up+1-i], layer[i].port);
   else
     connect(heatingCoil1.Therm1[i-n_HC1_low+1], layer[i].port);
 end if;

end for;
end if;

    if use_heatingCoil2 then

 for i in n_HC2_low:n_HC2_up loop
   if Up_to_down_HC2 == true then
     connect(heatingCoil2.Therm1[n_HC2_up+1-i], layer[i].port);
   else
     connect(heatingCoil2.Therm1[i-n_HC2_low+1], layer[i].port);
 end if;

end for;
    end if;

  for i in 1:n loop
    T_layers[i] = layer[i].T;
  end for;
//   T_Top = layer[n].T;
//   T_Mid = layer[integer(BaseLib.Utilities.Round(n/2 + 0.5,0))].T;
//   T_Bottom = layer[1].T;

connect(heatTransfer.therm, layer.port);

   connect(varTemp_load.port, dummy_load.port) annotation (Line(
       points={{120,34},{94,34},{94,54},{118,54}},
       color={191,0,0},
       smooth=Smooth.None));
  connect(varTemp_unload.port, dummy_unload.port) annotation (Line(
      points={{120,-46},{96,-46},{96,-26},{118,-26}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(port_HC1_in, heatingCoil1.enthalpyPort_a1) annotation (Line(
      points={{-100,80},{-72,80},{-72,73.4}},
      color={176,0,0},
      smooth=Smooth.None));
  connect(heatingCoil1.enthalpyPort_b1, port_HC1_out) annotation (Line(
      points={{-72,45.2},{-72,40},{-100,40}},
      color={176,0,0},
      smooth=Smooth.None));
  connect(port_HC2_in, heatingCoil2.enthalpyPort_a1) annotation (Line(
      points={{-100,-40},{-72,-40},{-72,-46.56}},
      color={176,0,0},
      smooth=Smooth.None));
  connect(port_HC2_out, heatingCoil2.enthalpyPort_b1) annotation (Line(
      points={{-100,-80},{-72,-80},{-72,-72.88}},
      color={176,0,0},
      smooth=Smooth.None));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}),            graphics),
    experiment(StopTime=3.1536e+007, Interval=600),
    __Dymola_experimentSetupOutput(events=false),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
                    graphics={
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
          origin={-20,79},
          rotation=180,
          visible = true),
        Line(
          points={{0,9},{0,-9}},
          color={0,0,0},
          smooth=Smooth.Bezier,
          thickness=1,
          arrow={Arrow.Filled,Arrow.None},
          origin={20,79},
          rotation=360,
          visible = true),
        Line(
          points={{0,9},{0,-9}},
          color={0,0,0},
          smooth=Smooth.Bezier,
          thickness=1,
          arrow={Arrow.Filled,Arrow.None},
          origin={-20,-79},
          rotation=180,
          visible = true),
        Line(
          points={{0,9},{0,-9}},
          color={0,0,0},
          smooth=Smooth.Bezier,
          thickness=1,
          arrow={Arrow.Filled,Arrow.None},
          origin={20,-79},
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
          visible=use_heatingCoil1),
        Line(
          points={{0,9},{0,-9}},
          color={0,0,0},
          smooth=Smooth.Bezier,
          thickness=1,
          arrow={Arrow.Filled,Arrow.None},
          origin={-66,25},
          rotation=90,
          visible = use_heatingCoil1),
        Rectangle(
          extent={{-80,100},{80,-100}},
          lineColor={0,0,0},
          lineThickness=1),
        Line(
          points={{-46,57},{56,57}},
          color={0,0,0},
          thickness=1,
          smooth=Smooth.Bezier,
          visible = use_heatingCoil1),
        Line(
          points={{-46,25},{56,25}},
          color={0,0,0},
          thickness=1,
          smooth=Smooth.Bezier,
          visible = use_heatingCoil1),
        Line(
          points={{-46,50},{56,57}},
          color={0,0,0},
          thickness=1,
          smooth=Smooth.Bezier,
          visible = use_heatingCoil1),
        Line(
          points={{56,42},{-46,50}},
          color={0,0,0},
          thickness=1,
          smooth=Smooth.Bezier,
          visible = use_heatingCoil1),
        Line(
          points={{-46,34},{56,42}},
          color={0,0,0},
          thickness=1,
          smooth=Smooth.Bezier,
          visible = use_heatingCoil1),
        Line(
          points={{56,26},{-46,34}},
          color={0,0,0},
          thickness=1,
          smooth=Smooth.Bezier,
          visible = use_heatingCoil1),
        Line(
          points={{0,9},{0,-9}},
          color={0,0,0},
          smooth=Smooth.Bezier,
          thickness=1,
          origin={-48,57},
          rotation=270,
          visible = (use_heatingCoil1 and Up_to_down_HC1)),
        Line(
          points={{0,9},{0,-9}},
          color={0,0,0},
          smooth=Smooth.Bezier,
          thickness=1,
          origin={-50,25},
          rotation=270,
          visible = (use_heatingCoil1 and Up_to_down_HC1)),
        Line(
          points={{0,9},{0,-9}},
          color={0,0,0},
          smooth=Smooth.Bezier,
          thickness=1,
          arrow={Arrow.Filled,Arrow.None},
          origin={-66,-25},
          rotation=270,
          visible=use_heatingCoil2),
        Line(
          points={{-46,-25},{56,-25}},
          color={0,0,0},
          thickness=1,
          smooth=Smooth.Bezier,
          visible = use_heatingCoil2),
        Line(
          points={{-46,-32},{56,-25}},
          color={0,0,0},
          thickness=1,
          smooth=Smooth.Bezier,
          visible = use_heatingCoil2),
        Line(
          points={{56,-40},{-46,-32}},
          color={0,0,0},
          thickness=1,
          smooth=Smooth.Bezier,
          visible = use_heatingCoil2),
        Line(
          points={{-46,-48},{56,-40}},
          color={0,0,0},
          thickness=1,
          smooth=Smooth.Bezier,
          visible = use_heatingCoil2),
        Line(
          points={{56,-56},{-46,-48}},
          color={0,0,0},
          thickness=1,
          smooth=Smooth.Bezier,
          visible = use_heatingCoil2),
        Line(
          points={{-46,-57},{56,-57}},
          color={0,0,0},
          thickness=1,
          smooth=Smooth.Bezier,
          visible = use_heatingCoil2),
        Line(
          points={{0,9},{0,-9}},
          color={0,0,0},
          smooth=Smooth.Bezier,
          thickness=1,
          origin={-50,-57},
          rotation=270,
          visible = (use_heatingCoil2 and Up_to_down_HC2)),
        Line(
          points={{0,9},{0,-9}},
          color={0,0,0},
          smooth=Smooth.Bezier,
          thickness=1,
          arrow={Arrow.Filled,Arrow.None},
          origin={-66,-57},
          rotation=90,
          visible = use_heatingCoil2),
        Line(
          points={{0,9},{0,-9}},
          color={0,0,0},
          smooth=Smooth.Bezier,
          thickness=1,
          origin={-48,-25},
          rotation=270,
          visible = (use_heatingCoil2 and Up_to_down_HC2)),
        Line(
          points={{-80,-2},{30,-2}},
          color={0,0,0},
          smooth=Smooth.None,
          thickness=1),
          Text(
          extent={{-80,10},{80,-10}},
          textString="%name",
          lineColor={0,0,255},
          origin={90,-20},
          rotation=90)}),
   Documentation(info="<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Buffer storage model with support for heating rod and two heating
  coils. Model with variable connection pairs for loading and unlouding
  cycles which are defined by the associated <u>storage layer
  number</u> of the ports.
</p>
<h4>
  <span style=\"color:#008000\">Level of Development</span>
</h4>
<p>
  <img src=\"modelica://HVAC/Images/stars2.png\" alt=\"\">
</p>
<h4>
  <span style=\"color:#008000\">Concept</span>
</h4>
<p>
  It represents a buffer storage stratified into n layers where 1
  represents the bottom layer and n represents the top layer. The
  layers are connected to each other allowing heat and fluid transfer.
  The conductance, buoyancy and enthalpy flow represent the heat
  transfer between the layers.
</p>
<p>
  The geometrical data for the storage is read by records in the
  DataBase package. In this model the number and the position of
  connection pairs for loading and unlouding cycles is variable. The
  position for each connection pair is defined by the associated
  storage layer number of input and output connection (compare
  connections tab).
</p>
<p>
  The model also includes heat losses over the storage walls (wall, top
  and bottom).
</p>
</html>",
revisions="<html><ul>
  <li>
    <i>December 20, 2016&#160;</i> Tobias Blacha:<br/>
    Moved into AixLib
  </li>
  <li>
    <i>January 27, 2015&#160;</i> by Konstantin Finkbeiner:<br/>
    Added documentation.
  </li>
  <li>
    <i>December 16, 2014</i> by Sebastian Stinner:<br/>
    Implemented.
  </li>
</ul>
</html>"));
end StorageSimpleWall;
