within AixLib.ThermalZones.ReducedOrder.RC;
model FourElements_TABS
  extends FourElements;
  // External TABS
  parameter Modelica.SIunits.Area ATabs=0 "Area of interior walls"
    annotation(Dialog(group="Tabs"));
  parameter AixLib.DataBase.Walls.WallBaseDataDefinition TABS_up=AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.BaseClasses.FloorLayers.Ceiling_Dummy()
    "Upper TABS layers"    annotation (Dialog(group="Tabs"), choicesAllMatching=true);
  parameter AixLib.DataBase.Walls.WallBaseDataDefinition TABS_lo=AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.BaseClasses.FloorLayers.Ceiling_Dummy() "Upper TABS layers"    annotation (Dialog(group="Tabs"), choicesAllMatching=true);

  parameter Modelica.SIunits.ThermalResistance RExt_tabs(
    min=Modelica.Constants.small)
    "Vector of resistances of exterior walls, from inside to outside"
    annotation(Dialog(group="Exterior tabs"));
  parameter Modelica.SIunits.ThermalResistance RExtRem_tabs(
    min=Modelica.Constants.small)
    "Resistance of remaining resistor RExtRem between capacity n and outside"
    annotation(Dialog(group="Exterior tabs"));
  parameter Modelica.SIunits.HeatCapacity CExt_tabs(
    min=Modelica.Constants.small)
    "Vector of heat capacities of exterior walls, from inside to outside"
    annotation(Dialog(group="Exterior tabs"));
  parameter Modelica.SIunits.Angle OrientationTabs[1] "Orientation of exterior tabs";
  // Internal TABS
  parameter Modelica.SIunits.Area ATabs_int=0 "Area of interior walls"
    annotation(Dialog(group="Tabs"));
  parameter AixLib.DataBase.Walls.WallBaseDataDefinition TABS_int_up=AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.BaseClasses.FloorLayers.Ceiling_Dummy()
    "Upper TABS layers"    annotation (Dialog(group="Tabs"), choicesAllMatching=true);
  parameter AixLib.DataBase.Walls.WallBaseDataDefinition TABS_int_lo=AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.BaseClasses.FloorLayers.Ceiling_Dummy() "Upper TABS layers"    annotation (Dialog(group="Tabs"), choicesAllMatching=true);

  parameter Modelica.SIunits.ThermalResistance RInt_tabs(
    min=Modelica.Constants.small)
    "Vector of resistances of interior tabs, from port to center"
    annotation(Dialog(group="Interior tabs"));
  parameter Modelica.SIunits.ThermalResistance RIntRem_tabs(
    min=Modelica.Constants.small)
    "Vector of resistances of interior tabs, from port to center"
    annotation(Dialog(group="Interior tabs"));
  parameter Modelica.SIunits.HeatCapacity CInt_tabs(
    min=Modelica.Constants.small)
    "Vector of heat capacities of interior tabs, from port to center"
    annotation(Dialog(group="Interior tabs"));
  parameter Modelica.SIunits.Angle OrientationTabsInt[1] "Orientation of exterior tabs";

  Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.Reduced.RCTABS rCTABS(
    final External=true,
    final UpperTABS=TABS_up,
    final LowerTABS=TABS_lo,
    final A=ATabs,
    OrientationTabs=OrientationTabs[1],
    final R_up=RExt_tabs,
    final C_up=CExt_tabs,
    final R_up_rest=RExtRem_tabs,
    final T_start=T_start) if   ATabs > 0 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-198,4})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a tabs if ATabs > 0
    "heat port for TABS"              annotation (Placement(transformation(
          extent={{-250,-172},{-230,-152}}), iconTransformation(extent={{-250,4},
            {-230,24}})));
  Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.Reduced.RCTABS rCTABS_int(
    final External=false,
    final UpperTABS=TABS_int_up,
    final LowerTABS=TABS_int_lo,
    final A=ATabs_int,
    OrientationTabs=OrientationTabsInt[1],
    R_up=RInt_tabs,
    C_up=CInt_tabs,
    R_up_rest=RIntRem_tabs,
    final T_start=T_start) if   ATabs_int > 0 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={210,-152})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a tabs_int if
                                                              ATabs_int > 0
    "heat port for TABS" annotation (Placement(transformation(extent={{-250,-190},
            {-230,-170}}),iconTransformation(extent={{-250,-24},{-230,-4}})));
protected
  Modelica.Thermal.HeatTransfer.Components.Convection convTABS(dT(start=0)) if
                                                                     ATabs > 0
    "Convective heat transfer of exterior walls"
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=0,
        origin={-168,8})));
  Modelica.Thermal.HeatTransfer.Components.Convection convTABS_int(dT(start=0)) if
                                                                     ATabs_int > 0
    "Convective heat transfer of exterior walls" annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={164,-150})));
equation
  connect(rCTABS.port_ext, extWallRC.port_b) annotation (Line(points={{-208,4},
          {-220,4},{-220,-40},{-178,-40}},                                                                color={191,0,0}));
  connect(senTAir.T,rCTABS. TAir) annotation (Line(points={{102,0},{102,24},{-218,
          24},{-218,8},{-209,8}},      color={0,0,127}));
  connect(rCTABS.alpha_TABS,convTABS.Gc) annotation (Line(points={{-209,12},{-212,
          12},{-212,22},{-184,22},{-184,-14},{-168,-14},{-168,-2}},      color=
          {0,0,127}));
  connect(convTABS.fluid, convExtWall.fluid) annotation (Line(points={{-158,8},{
          -158,-6},{-94,-6},{-94,-40}},  color={191,0,0}));
  connect(rCTABS.port_int, extWallRC.port_a) annotation (Line(points={{-188,4},{
          -178,4},{-178,-22},{-158,-22},{-158,-40}}, color={191,0,0}));
  connect(convTABS.solid, convExtWall.solid) annotation (Line(points={{-178,8},{
          -178,-16},{-114,-16},{-114,-40}}, color={191,0,0}));
  connect(rCTABS.port_heat,tabs)  annotation (Line(points={{-198,-6},{-198,-20},
          {-240,-20},{-240,-162}},                color={191,0,0}));

  connect(rCTABS_int.port_heat,tabs_int)  annotation (Line(points={{210,-162},{210,
          -168},{-226,-168},{-226,-180},{-240,-180}},
                                    color={191,0,0}));
  connect(senTAir.T,rCTABS_int.TAir) annotation (Line(points={{102,0},{56,0},{56,
          -148},{199,-148}},     color={0,0,127}));
  connect(convTABS_int.Gc,rCTABS_int.alpha_TABS) annotation (Line(points={{164,
          -140},{164,-124},{186,-124},{186,-144},{199,-144}}, color={0,0,127}));
  connect(convTABS_int.fluid, convIntWall.fluid) annotation (Line(points={{154,-150},
          {128,-150},{128,-40}},                       color={191,0,0}));
  connect(convTABS_int.solid, convIntWall.solid) annotation (Line(points={{174,-150},
          {174,-132},{160,-132},{160,-40},{148,-40}},            color={191,0,0}));
  connect(rCTABS_int.port_int, intWallRC.port_a) annotation (Line(points={{220,-152},
          {226,-152},{226,-88},{182,-88},{182,-40}},   color={191,0,0}));
  annotation (Diagram(graphics={
  Rectangle(
    extent={{-230,20},{-186,-14}},
    lineColor={0,0,255},
    fillColor={215,215,215},
    fillPattern=FillPattern.Solid),
  Text(
    extent={{-27.5,8.5},{27.5,-8.5}},
    lineColor={0,0,255},
    fillColor={215,215,215},
    fillPattern=FillPattern.Solid,
          origin={-219.5,4.5},
          rotation=90,
          textString="TABS
"),
  Rectangle(
    extent={{190,-134},{234,-176}},
    lineColor={0,0,255},
    fillColor={215,215,215},
    fillPattern=FillPattern.Solid),
  Text(
    extent={{-21.5,11},{21.5,-11}},
    lineColor={0,0,255},
    fillColor={215,215,215},
    fillPattern=FillPattern.Solid,
          origin={235,-155.5},
          rotation=90,
          textString="TABS_int
")}));
end FourElements_TABS;
