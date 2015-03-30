within AixLib.HVAC.Valves;
package BaseClasses
  extends Modelica.Icons.BasesPackage;

  partial model PartialTeeJunction
    import AixLib;

    AixLib.HVAC.Interfaces.Port_a port_1
      annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
    AixLib.HVAC.Interfaces.Port_a port_3
      annotation (Placement(transformation(extent={{-10,90},{10,110}})));
    AixLib.HVAC.Interfaces.Port_b port_2
      annotation (Placement(transformation(extent={{90,-10},{110,10}})));

    annotation (Documentation(info="<html>
<h4>Base class for a splitting/joining component with three ports</h4>
</html>", revisions="<html>
<p>26.11.2014, by <i>Roozbeh Sangi</i>: implemented </p>
</html>"));
  end PartialTeeJunction;
end BaseClasses;
