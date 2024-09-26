within AixLib.Fluid.HeatPumps.ModularReversible.RefrigerantCycle.BaseClasses;
partial model PartialTableDataSDF
  "Partial model with components for table data using ND SDF tables for heat pumps and chillers"
  parameter Integer nDim=1 "Number of input dimensions";
  parameter Real scaFac "Scaling factor";
  parameter SDF.Types.InterpolationMethod interpMethod=SDF.Types.InterpolationMethod.Linear
    "Interpolation method" annotation(Dialog(group="Data handling"));
  parameter SDF.Types.ExtrapolationMethod extrapMethod=SDF.Types.ExtrapolationMethod.Hold
    "Extrapolation method" annotation(Dialog(group="Data handling"));
  Modelica.Blocks.Math.Product scaFacTimPel "Scale electrical power consumption"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-40,-10})));
  Modelica.Blocks.Math.Product scaFacTimQUse_flow "Scale useful heat flow rate"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={40,-10})));
  Modelica.Blocks.Sources.Constant constScaFac(final k=scaFac)
    "Calculates correction of table output based on scaling factor"
    annotation (Placement(
        transformation(extent={{-10,-10},{10,10}}, rotation=0,
        origin={-110,90})));

  Modelica.Blocks.Routing.RealPassThrough reaPasThrTEvaIn if (not useInRevDev and not use_TEvaOutForTab) or (useInRevDev and not use_TConOutForTab)
    "Used to enable conditional bus connection" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-50,90})));
  Modelica.Blocks.Routing.RealPassThrough reaPasThrTConIn if (not useInRevDev and not use_TConOutForTab) or (useInRevDev and not use_TEvaOutForTab)
    "Used to enable conditional bus connection" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={50,90})));
  Modelica.Blocks.Routing.RealPassThrough reaPasThrTEvaOut if (not useInRevDev and use_TEvaOutForTab) or (useInRevDev and use_TConOutForTab)
    "Used to enable conditional bus connection" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-10,90})));
  Modelica.Blocks.Routing.RealPassThrough reaPasThrTConOut if (not useInRevDev and use_TConOutForTab) or (useInRevDev and use_TEvaOutForTab)
    "Used to enable conditional bus connection" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={90,90})));

  Modelica.Blocks.Math.Gain facGain[nDim]
    "Convert relative speed n to an absolute value for interpolation in sdf tables"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-10,50})));
  SDF.NDTable nDTabQUse_flow(
    final nin=nDim,
    final readFromFile=true,
    final interpMethod=interpMethod,
    final extrapMethod=extrapMethod) "SDF-Table data for condenser heat flow"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={70,30})));
  SDF.NDTable nDTabPEle(
    final nin=nDim,
    final readFromFile=true,
    final interpMethod=interpMethod,
    final extrapMethod=extrapMethod) "SDF table data for electrical power"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={10,30})));

  Modelica.Blocks.Routing.Multiplex  mux(final n=nDim)
                "Concat all inputs into an array"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-70,50})));
  RearrangeInputs ordInp(final nDim=nDim) "Possibly change Input order" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-40,50})));
  Modelica.Blocks.Math.Product onOffTimScaFac
    "Create the product of the scaling factor and whether the device is even on"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-100,30})));
  Modelica.Blocks.Math.BooleanToReal booToRea(final realTrue=1, final realFalse
      =0) "Convert on/off signal to real" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-80,90})));
protected
  parameter Real u_nominal[nDim]
    "Nominal conditions input array";
  parameter Real uOrdSca_nominal[nDim] = {u_nominal[ordInp.outOrd[i]] for i in 1:nDim} .* facGain.k
    "Nominal conditions input array ordered and scaled for sdf";
  parameter Boolean use_TEvaOutForTab=true
    "=true to use evaporator outlet temperature, false for inlet";
  parameter Boolean use_TConOutForTab=true
    "=true to use condenser outlet temperature, false for inlet";

  parameter Boolean useInRevDev "=true to indicate usage in reversed operation";
  parameter SDF.Types.ExternalNDTable extTabQUse_flow=SDF.Types.ExternalNDTable(
       nDTabQUse_flow.nin, SDF.Functions.readTableData(
      Modelica.Utilities.Files.loadResource(nDTabQUse_flow.filename),
      nDTabQUse_flow.dataset,
      nDTabQUse_flow.dataUnit,
      nDTabQUse_flow.scaleUnits));
  parameter SDF.Types.ExternalNDTable extTabPEle=SDF.Types.ExternalNDTable(
       nDTabPEle.nin, SDF.Functions.readTableData(
      Modelica.Utilities.Files.loadResource(nDTabPEle.filename),
      nDTabPEle.dataset,
      nDTabPEle.dataUnit,
      nDTabPEle.scaleUnits));
  function evaluate
    input SDF.Types.ExternalNDTable table;
    input Real[:] params;
    input SDF.Types.InterpolationMethod interpMethod;
    input SDF.Types.ExtrapolationMethod extrapMethod;
    output Real value;
    external "C" value = ModelicaNDTable_evaluate(table, size(params, 1), params, interpMethod, extrapMethod) annotation (
      Include="#include <ModelicaNDTable.c>",
      IncludeDirectory="modelica://SDF/Resources/C-Sources");
  end evaluate;
equation
  connect(nDTabPEle.y, scaFacTimPel.u1) annotation (Line(points={{10,19},{10,10},
          {-34,10},{-34,2}},  color={0,0,127}));
  connect(nDTabQUse_flow.y, scaFacTimQUse_flow.u1) annotation (Line(points={{70,19},
          {70,12},{46,12},{46,2}},      color={0,0,127}));
  connect(facGain.y, nDTabQUse_flow.u)
    annotation (Line(points={{1,50},{70,50},{70,42}}, color={0,0,127}));
  connect(facGain.y, nDTabPEle.u)
    annotation (Line(points={{1,50},{10,50},{10,42}}, color={0,0,127}));
  connect(ordInp.y, facGain.u)
    annotation (Line(points={{-29,50},{-22,50}}, color={0,0,127}));
  connect(mux.y, ordInp.u)
    annotation (Line(points={{-59,50},{-52,50}}, color={0,0,127}));
  connect(onOffTimScaFac.y, scaFacTimPel.u2) annotation (Line(points={{-100,19},
          {-100,2},{-54,2},{-54,10},{-46,10},{-46,2}}, color={0,0,127}));
  connect(onOffTimScaFac.y, scaFacTimQUse_flow.u2) annotation (Line(points={{
          -100,19},{-100,2},{-54,2},{-54,-28},{26,-28},{26,2},{34,2}}, color={0,
          0,127}));
  connect(constScaFac.y, onOffTimScaFac.u2) annotation (Line(points={{-99,90},{
          -96,90},{-96,50},{-106,50},{-106,42}}, color={0,0,127}));
  connect(booToRea.y, onOffTimScaFac.u1) annotation (Line(points={{-80,79},{-80,
          76},{-94,76},{-94,42}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-120,
            -120},{120,120}})),
    Documentation(info="<html>
<p>
  Partial model for equations and componenents used in both heat pump
  and chiller models using SDF based data.
</p>
</html>", revisions="<html>
<ul>  <li>
    <i>August 27, 2024</i> by Fabian Wuellhorst:<br/>
    First implementation (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/1520\">AixLib #1520</a>)
  </li></ul>
</html>"),
    Icon(coordinateSystem(extent={{-120,-120},{120,120}}), graphics={
                                Rectangle(
        extent={{-120,-122},{122,120}},
        lineColor={0,0,127},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
      Rectangle(
          extent={{-60,60},{60,-60}},
          lineColor={47,49,172},
          fillColor={255,255,125},
          fillPattern=FillPattern.Solid),
      Line(
        points={{-20,60},{-20,-60}},
        color={161,159,189}),
      Line(
        points={{20,60},{20,-60}},
        color={161,159,189}),
      Line(
        points={{1,64},{1,-56}},
        color={161,159,189},
          origin={4,-21},
          rotation=90),
      Line(
        points={{1,76},{1,-44}},
        color={161,159,189},
          origin={16,19},
          rotation=90),
      Rectangle(
          extent={{-60,60},{60,-60}},
          lineColor={47,49,172})}));
end PartialTableDataSDF;
