within AixLib.FastHVAC.Components.Storage.BaseClasses;
partial model PartialHeatTransferLayers

  final outer parameter Integer n(min=2)=3;
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a[n] therm annotation (
      Placement(transformation(extent={{40,0},{60,20}}, rotation=0)));
   // Modelica_Fluid.Interfaces.FluidPort_a[n+1] fluidport(  redeclare final
   //   package Medium =
   //             Medium) annotation 1;

  final outer replaceable package Medium =
       FastHVAC.Media.WaterSimple "Medium model"   annotation(choicesAllMatching);

final outer replaceable parameter
    AixLib.DataBase.Storage.BufferStorageBaseDataDefinition data=
      AixLib.DataBase.Storage.Generic_New_2000l()
    annotation (choicesAllMatching);

  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
            -100,-100},{100,100}}),
                      graphics),
                       Icon(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}), graphics={
        Rectangle(
          extent={{-40,70},{40,-50}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={85,170,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-40,-10},{-30,2},{-16,16},{-6,20},{4,16},{14,4},{22,-16},
              {34,-24},{40,-26},{40,-50},{-40,-50},{-40,-10}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          smooth=Smooth.None,
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-40,-30},{-34,-16},{-16,2},{-6,2},{4,-6},{16,-24},{22,-40},
              {38,-50},{-40,-50},{-40,-30}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          smooth=Smooth.None,
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-40,-50},{-32,-30},{-20,-12},{-8,-10},{8,-28},{14,-42},{
              24,-50},{-40,-50}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          smooth=Smooth.None,
          fillColor={255,62,62},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-40,0},{-16,38},{-2,40},{6,34},{14,16},{26,-6},{40,-12},
              {40,70},{-40,70},{-40,0}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          smooth=Smooth.None,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid)}),
    Documentation(info="<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p>Partial model for different heat transfer layer models.</p>
<p><h4><font color=\"#008000\">Level of Development</font></h4></p>
<p><img src=\"modelica://HVAC/Images/stars2.png\"/> </p>
</html>",
      revisions="<html>
<p><ul>
<li><i>December 20, 2016&nbsp; </i> Tobias Blacha:<br/>Moved into AixLib</li>
<li><i>October 2, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
</ul></p>
</html>
"));
  //Modelica.Blocks.Interfaces.RealInput m_flow annotation 5;
  //Modelica.Blocks.Interfaces.RealInput[n+1] H_flow
  //  "Enthalpy flow between the volumes" annotation 6;

end PartialHeatTransferLayers;
