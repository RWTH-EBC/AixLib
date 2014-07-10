within AixLib.DataBase;
package Walls "Database for different types of walls"
      extends Modelica.Icons.Package;

  record WallBaseDataDefinition "Wall base data definition"
      extends Modelica.Icons.Record;
    // pma 2010-04-28: REMOVED THE BASE DEFINITIONS to get errors thrown when using unparameterised wall models
    parameter Integer n(min=1) = 3 "Number of wall layers"     annotation(Dialog(tab="Wall 1", group="Wall 1 parameters"));
    parameter Modelica.SIunits.Length d[n] "Thickness of wall layers"
                                 annotation(Dialog(tab="Wall 1", group="Layer 1 parameters"));
    parameter Modelica.SIunits.Density rho[n] "Density of wall layers"
                               annotation(Dialog(tab="Wall 1", group="Layer 1 parameters"));
    parameter Modelica.SIunits.ThermalConductivity lambda[n]
      "Thermal conductivity of wall layers" annotation(Dialog(tab="Wall 1", group="Wall 1 parameters"));
    parameter Modelica.SIunits.SpecificHeatCapacity c[n]
      "Specific heat capacity of wall layers" annotation(Dialog(tab="Wall 1", group="Wall 1 parameters"));
    parameter Modelica.SIunits.Emissivity eps=0.95
      "Emissivity of inner wall surface" annotation(Dialog(tab="Wall 1", group="Wall 1 parameters"));
    annotation (Documentation(info="<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p>Wall BaseDataDefinition actually doesn&apos;t need predefined values and that is desirable to get errors thrown when using an unparameterised wall in a model. </p>
<p><h4><font color=\"#008000\">Level of Development</font></h4></p>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
<p><h4><font color=\"#008000\">Concept</font></h4></p>
<p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>port_a</code>(outside), the last element represents the layer connected to <code>port_b</code>(surface facing the room). </p>
<p><h4><font color=\"#008000\">References</font></h4></p>
<p>Base data definition for record to be used in model <a href=\"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a></p>
</html>", revisions="<html>
<p><ul>
<li><i>September 3, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately</li>
</ul></p>
</html>"));
  end WallBaseDataDefinition;

  package WSchV1984
        extends Modelica.Icons.Package;

    package OW
          extends Modelica.Icons.Package;

      record OW_WSchV1984_S
        "outer wall after WSchV1984, for building of type S (schwer)"
        extends WallBaseDataDefinition(
          n(min=1) = 4 "Number of wall layers",
          d={0.05,0.06,0.175,0.015} "Thickness of wall layers",
          rho={1800,120,1600,1200} "Density of wall layers",
          lambda={1.0,0.05,0.79,0.51} "Thermal conductivity of wall layers",
          c={1000,1030,1000,1000} "Specific heat capacity of wall layers",
          eps=0.95 "Emissivity of inner wall surface");

        annotation (Documentation(revisions="<html>
<p><ul>
<li><i>September 5, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
<li><i>August 15, 2011</i> by Ana Constantin:<br/>implemented</li>
</ul></p>
</html>", info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Wall definition according to WSchV 1984. For detailed wall type see above. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars5.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>port_a</code>(outside), the last element represents the layer connected to <code>port_b</code>(surface facing the room). </p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a></p>
<p>Norm: </p>
<ul>
<li>W&auml;rmeschutzverordnung 1984. 1984</li>
</ul>
</html>"));
      end OW_WSchV1984_S;

      record OW_WSchV1984_M
        "outer wall after WSchV1984, for building of type M (mittel)"
        extends WallBaseDataDefinition(
          n(min=1) = 4 "Number of wall layers",
          d={0.05,0.04,0.18,0.015} "Thickness of wall layers",
          rho={1800,120,800,1200} "Density of wall layers",
          lambda={1.0,0.055,0.25,0.51} "Thermal conductivity of wall layers",
          c={1000,1030,1000,1000} "Specific heat capacity of wall layers",
          eps=0.95 "Emissivity of inner wall surface");
        annotation (Documentation(revisions="<html>
<p><ul>
<li><i>September 5, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
<li><i>August 15, 2011</i> by Ana Constantin:<br/>implemented</li>
</ul></p>
</html>", info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Wall definition according to WSchV 1984. For detailed wall type see above. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars5.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>port_a</code>(outside), the last element represents the layer connected to <code>port_b</code>(surface facing the room). </p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a></p>
<p>Norm: </p>
<ul>
<li>W&auml;rmeschutzverordnung 1984. 1984</li>
</ul>
</html>"));
      end OW_WSchV1984_M;

      record OW_WSchV1984_L
        "outer wall after WSchV1984, for building of type L (leicht)"
        // New Walls for Dymola 2012, the same number of layers as other mass clases
        extends WallBaseDataDefinition(
          n(min=1) = 4 "Number of wall layers",
          d={0.03,0.02,0.18,0.0275} "Thickness of wall layers",
          rho={1800,900,127,1018.2} "Density of wall layers",
          lambda={1.0,0.18,0.14,0.346} "Thermal conductivity of wall layers",
          c={1000,1700,1445,1000} "Specific heat capacity of wall layers",
          eps=0.95 "Emissivity of inner wall surface");

      //     n(min=1) = 5 "Number of wall layers",
      //    d={0.03,0.02,0.18,0.0125,0.015} "Thickness of wall layers",
      //    rho={1800,900,127,800,1200} "Density of wall layers",
      //    lambda={1.0,0.18,0.14,0.25,0.51} "Thermal conductivity of wall layers",
      //    c={1000,1700,1445,1000,1000} "Specific heat capacity of wall layers",
      //    eps=0.95 "Emissivity of inner wall surface");
        annotation (Documentation(revisions="<html>
<p><ul>
<li><i>September 5, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
<li><i>August 15, 2011</i> by Ana Constantin:<br/>implemented</li>
</ul></p>
</html>", info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Wall definition according to WSchV 1984. For detailed wall type see above. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars5.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>port_a</code>(outside), the last element represents the layer connected to <code>port_b</code>(surface facing the room). </p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a></p>
<p>Norm: </p>
<ul>
<li>W&auml;rmeschutzverordnung 1984. 1984</li>
</ul>
</html>"));
      end OW_WSchV1984_L;
    end OW;

    package IW
          extends Modelica.Icons.Package;

      record IWsimple_WSchV1984_S_half
        "Inner wall simple after WSchV1984, for building of type S (schwer), only half"
        extends WallBaseDataDefinition(
          n(min=1) = 2 "Number of wall layers",
          d={0.0575,0.015} "Thickness of wall layers",
          rho={1600,1200} "Density of wall layers",
          lambda={0.79,0.51} "Thermal conductivity of wall layers",
          c={1000,1000} "Specific heat capacity of wall layers",
          eps=0.95 "Emissivity of inner wall surface");
        annotation (Documentation(revisions="<html>
<p><ul>
<li><i>September 5, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
<li><i>August 15, 2011</i> by Ana Constantin:<br/>implemented</li>
</ul></p>
</html>", info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Wall definition according to WSchV 1984. For detailed wall type see above. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars5.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>port_a</code>(outside), the last element represents the layer connected to <code>port_b</code>(surface facing the room). </p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a></p>
<p>Norm: </p>
<ul>
<li>W&auml;rmeschutzverordnung 1984. 1984</li>
</ul>
</html>"));
      end IWsimple_WSchV1984_S_half;

      record IWload_WSchV1984_S_half
        "Inner wall load-bearing after WSchV1984, for building of type S (schwer), only half"
        extends WallBaseDataDefinition(
          n(min=1) = 2 "Number of wall layers",
          d={0.0875,0.015} "Thickness of wall layers",
          rho={1600,1200} "Density of wall layers",
          lambda={0.79,0.51} "Thermal conductivity of wall layers",
          c={1000,1000} "Specific heat capacity of wall layers",
          eps=0.95 "Emissivity of inner wall surface");
        annotation (Documentation(revisions="<html>
<p><ul>
<li><i>September 5, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
<li><i>August 15, 2011</i> by Ana Constantin:<br/>implemented</li>
</ul></p>
</html>", info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Wall definition according to WSchV 1984. For detailed wall type see above. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars5.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>port_a</code>(outside), the last element represents the layer connected to <code>port_b</code>(surface facing the room). </p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a></p>
<p>Norm: </p>
<ul>
<li>W&auml;rmeschutzverordnung 1984. 1984</li>
</ul>
</html>"));
      end IWload_WSchV1984_S_half;

      record IWneighbour_WSchV1984_S_half
        "Inner wall towards neighbour after WSchV1984, for building of type S (schwer), only half"
        extends WallBaseDataDefinition(
          n(min=1) = 3 "Number of wall layers",
          d={0.02,0.175,0.015} "Thickness of wall layers",
          rho={1.23,1600,1200} "Density of wall layers",
          lambda={0.22,0.79,0.51} "Thermal conductivity of wall layers",
          c={1008,1000,1000} "Specific heat capacity of wall layers",
          eps=0.95 "Emissivity of inner wall surface");
        annotation (Documentation(revisions="<html>
<p><ul>
<li><i>September 5, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
<li><i>August 15, 2011</i> by Ana Constantin:<br/>implemented</li>
</ul></p>
</html>", info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Wall definition according to WSchV 1984. For detailed wall type see above. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars5.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>port_a</code>(outside), the last element represents the layer connected to <code>port_b</code>(surface facing the room). </p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a></p>
<p>Norm: </p>
<ul>
<li>W&auml;rmeschutzverordnung 1984. 1984</li>
</ul>
</html>"));
      end IWneighbour_WSchV1984_S_half;

      record IWsimple_WSchV1984_M_half
        "Inner wall simple after WSchV1984, for building of type M (mittel), only half"
        extends WallBaseDataDefinition(
          n(min=1) = 2 "Number of wall layers",
          d={0.0575,0.015} "Thickness of wall layers",
          rho={1000,1200} "Density of wall layers",
          lambda={0.315,0.51} "Thermal conductivity of wall layers",
          c={1000,1000} "Specific heat capacity of wall layers",
          eps=0.95 "Emissivity of inner wall surface");
        annotation (Documentation(revisions="<html>
<p><ul>
<li><i>September 5, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
<li><i>August 15, 2011</i> by Ana Constantin:<br/>implemented</li>
</ul></p>
</html>", info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Wall definition according to WSchV 1984. For detailed wall type see above. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars5.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>port_a</code>(outside), the last element represents the layer connected to <code>port_b</code>(surface facing the room). </p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a></p>
<p>Norm: </p>
<ul>
<li>W&auml;rmeschutzverordnung 1984. 1984</li>
</ul>
</html>"));
      end IWsimple_WSchV1984_M_half;

      record IWload_WSchV1984_M_half
        "Inner wall load-bearing after WSchV1984, for building of type M (schwer), only half"
        extends WallBaseDataDefinition(
          n(min=1) = 2 "Number of wall layers",
          d={0.0875,0.015} "Thickness of wall layers",
          rho={1000,1200} "Density of wall layers",
          lambda={0.315,0.51} "Thermal conductivity of wall layers",
          c={1000,1000} "Specific heat capacity of wall layers",
          eps=0.95 "Emissivity of inner wall surface");
        annotation (Documentation(revisions="<html>
<p><ul>
<li><i>September 5, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
<li><i>August 15, 2011</i> by Ana Constantin:<br/>implemented</li>
</ul></p>
</html>", info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Wall definition according to WSchV 1984. For detailed wall type see above. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars5.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>port_a</code>(outside), the last element represents the layer connected to <code>port_b</code>(surface facing the room). </p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a></p>
<p>Norm: </p>
<ul>
<li>W&auml;rmeschutzverordnung 1984. 1984</li>
</ul>
</html>"));
      end IWload_WSchV1984_M_half;

      record IWneighbour_WSchV1984_M_half
        "Inner wall towards neighbour after WSchV1984, for building of type S (mitel), only half"
        extends WallBaseDataDefinition(
          n(min=1) = 3 "Number of wall layers",
          d={0.02,0.175,0.015} "Thickness of wall layers",
          rho={1.23,1000,1200} "Density of wall layers",
          lambda={0.22,0.315,0.51} "Thermal conductivity of wall layers",
          c={1008,1000,1000} "Specific heat capacity of wall layers",
          eps=0.95 "Emissivity of inner wall surface");
        annotation (Documentation(revisions="<html>
<p><ul>
<li><i>September 5, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
<li><i>August 15, 2011</i> by Ana Constantin:<br/>implemented</li>
</ul></p>
</html>", info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Wall definition according to WSchV 1984. For detailed wall type see above. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars5.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>port_a</code>(outside), the last element represents the layer connected to <code>port_b</code>(surface facing the room). </p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a></p>
<p>Norm: </p>
<ul>
<li>W&auml;rmeschutzverordnung 1984. 1984</li>
</ul>
</html>"));
      end IWneighbour_WSchV1984_M_half;

      record IWsimple_WSchV1984_L_half
        "Inner wall simple after WSchV1984, for building of type L (leicht), only half"
        // New Walls for Dymola 2012, the same number of layers as other mass clases
        extends WallBaseDataDefinition(
          n(min=1) = 2 "Number of wall layers",
          d={0.05,0.0275} "Thickness of wall layers",
          rho={93,1018.2} "Density of wall layers",
          lambda={0.44,0.346} "Thermal conductivity of wall layers",
          c={1593,1000} "Specific heat capacity of wall layers",
          eps=0.95 "Emissivity of inner wall surface");

      //    n(min=1) = 3 "Number of wall layers",
      //    d={0.05,0.0125,0.015} "Thickness of wall layers",
      //    rho={93,800,1200} "Density of wall layers",
      //    lambda={0.44,0.25,0.51} "Thermal conductivity of wall layers",
      //    c={1593,1000,1000} "Specific heat capacity of wall layers",
      //    eps=0.95 "Emissivity of inner wall surface");
        annotation (Documentation(revisions="<html>
<p><ul>
<li><i>September 5, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
<li><i>August 15, 2011</i> by Ana Constantin:<br/>implemented</li>
</ul></p>
</html>", info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Wall definition according to WSchV 1984. For detailed wall type see above. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars5.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>port_a</code>(outside), the last element represents the layer connected to <code>port_b</code>(surface facing the room). </p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a></p>
<p>Norm: </p>
<ul>
<li>W&auml;rmeschutzverordnung 1984. 1984</li>
</ul>
</html>"));
      end IWsimple_WSchV1984_L_half;

      record IWload_WSchV1984_L_half
        "Inner wall load-bearing after WSchV1984, for building of type L (leicht), only half"
        // New Walls for Dymola 2012, the same number of layers as other mass clases
        extends WallBaseDataDefinition(
          n(min=1) = 2 "Number of wall layers",
          d={0.09,0.0275} "Thickness of wall layers",
          rho={93,1018.2} "Density of wall layers",
          lambda={0.78,0.346} "Thermal conductivity of wall layers",
          c={1593,1000} "Specific heat capacity of wall layers",
          eps=0.95 "Emissivity of inner wall surface");

      //     n(min=1) = 3 "Number of wall layers",
      //    d={0.09,0.0125,0.015} "Thickness of wall layers",
      //    rho={93,800,1200} "Density of wall layers",
      //    lambda={0.78,0.25,0.51} "Thermal conductivity of wall layers",
      //    c={1593,1000,1000} "Specific heat capacity of wall layers",
      //    eps=0.95 "Emissivity of inner wall surface");
        annotation (Documentation(revisions="<html>
<p><ul>
<li><i>September 5, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
<li><i>August 15, 2011</i> by Ana Constantin:<br/>implemented</li>
</ul></p>
</html>", info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Wall definition according to WSchV 1984. For detailed wall type see above. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars5.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>port_a</code>(outside), the last element represents the layer connected to <code>port_b</code>(surface facing the room). </p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a></p>
<p>Norm: </p>
<ul>
<li>W&auml;rmeschutzverordnung 1984. 1984</li>
</ul>
</html>"));
      end IWload_WSchV1984_L_half;

      record IWneighbour_WSchV1984_L_half
        "Inner wall towards neighbour after WSchV1984, for building of type L (leicht), only half"
        // New Walls for Dymola 2012, the same number of layers as other mass clases
        extends WallBaseDataDefinition(
          n(min=1) = 3 "Number of wall layers",
          d={0.0325,0.18,0.0275} "Thickness of wall layers",
          rho={308.4,93,1018.2} "Density of wall layers",
          lambda={0.23,0.35,0.346} "Thermal conductivity of wall layers",
          c={1000,1593,1000} "Specific heat capacity of wall layers",
          eps=0.95 "Emissivity of inner wall surface");

      //    n(min=1) = 5 "Number of wall layers",
      //    d={0.02,0.0125,0.18,0.0125,0.015} "Thickness of wall layers",
      //    rho={1.23,800,93,800,1200} "Density of wall layers",
      //    lambda={0.22,0.25,0.35,0.25,0.51} "Thermal conductivity of wall layers",
      //    c={1008,1000,1593,1000,1000} "Specific heat capacity of wall layers",
      //    eps=0.95 "Emissivity of inner wall surface");
        annotation (Documentation(revisions="<html>
<p><ul>
<li><i>September 5, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
<li><i>August 15, 2011</i> by Ana Constantin:<br/>implemented</li>
</ul></p>
</html>", info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Wall definition according to WSchV 1984. For detailed wall type see above. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars5.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>port_a</code>(outside), the last element represents the layer connected to <code>port_b</code>(surface facing the room). </p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a></p>
<p>Norm: </p>
<ul>
<li>W&auml;rmeschutzverordnung 1984. 1984</li>
</ul>
</html>"));
      end IWneighbour_WSchV1984_L_half;
    end IW;

    package Floor
          extends Modelica.Icons.Package;

    record FLground_WSchV1984_SML
        "Floor towards ground after WSchV1984, for building of type S (schwer), M (mittel) and L (leicht)"
        extends WallBaseDataDefinition(
          n(min=1) = 4 "Number of wall layers",
          d={0.02,0.25,0.04,0.06} "Thickness of wall layers",
          rho={100,2300,120,2000} "Density of wall layers",
          lambda={0.05,2.3,0.055,1.4} "Thermal conductivity of wall layers",
          c={1000,1000,1030,1000} "Specific heat capacity of wall layers",
          eps=0.95 "Emissivity of inner wall surface");
        annotation (Documentation(revisions="<html>
<p><ul>
<li><i>September 5, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
<li><i>August 15, 2011</i> by Ana Constantin:<br/>implemented</li>
</ul></p>
</html>",
    info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Wall definition according to WSchV 1984. For detailed wall type see above. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars5.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>port_a</code>(outside), the last element represents the layer connected to <code>port_b</code>(surface facing the room). </p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a></p>
<p>Norm: </p>
<ul>
<li>W&auml;rmeschutzverordnung 1984. 1984</li>
</ul>
</html>"));
    end FLground_WSchV1984_SML;

    record FLpartition_WSchV1984_SM_upHalf
        "Floor partition after WSchV1984, for building of type S (schwer) and M (mittel), upper half"
        extends WallBaseDataDefinition(
          n(min=1) = 2 "Number of wall layers",
          d={0.02,0.06} "Thickness of wall layers",
          rho={120,2000} "Density of wall layers",
          lambda={0.055,1.4} "Thermal conductivity of wall layers",
          c={1030,1000} "Specific heat capacity of wall layers",
          eps=0.95 "Emissivity of inner wall surface");
        annotation (Documentation(revisions="<html>
<p><ul>
<li><i>September 5, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
<li><i>August 15, 2011</i> by Ana Constantin:<br/>implemented</li>
</ul></p>
</html>",
    info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Wall definition according to WSchV 1984. For detailed wall type see above. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars5.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>port_a</code>(outside), the last element represents the layer connected to <code>port_b</code>(surface facing the room). </p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a></p>
<p>Norm: </p>
<ul>
<li>W&auml;rmeschutzverordnung 1984. 1984</li>
</ul>
</html>"));
    end FLpartition_WSchV1984_SM_upHalf;

    record FLpartition_WSchV1984_L_upHalf
        "Floor partition after WSchV1984, for building of typeL (leicht), upper half"
        extends WallBaseDataDefinition(
          n(min=1) = 2 "Number of wall layers",
          d={0.02,0.06} "Thickness of wall layers",
          rho={120,2000} "Density of wall layers",
          lambda={0.055,1.4} "Thermal conductivity of wall layers",
          c={1030,1000} "Specific heat capacity of wall layers",
          eps=0.95 "Emissivity of inner wall surface");
        annotation (Documentation(revisions="<html>
<p><ul>
<li><i>September 5, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
<li><i>August 15, 2011</i> by Ana Constantin:<br/>implemented</li>
</ul></p>
</html>",
    info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Wall definition according to WSchV 1984. For detailed wall type see above. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars5.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>port_a</code>(outside), the last element represents the layer connected to <code>port_b</code>(surface facing the room). </p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a></p>
<p>Norm: </p>
<ul>
<li>W&auml;rmeschutzverordnung 1984. 1984</li>
</ul>
</html>"));
    end FLpartition_WSchV1984_L_upHalf;

    record FLcellar_WSchV1984_SML_upHalf
        "Floor towards cellar after WSchV1984, for building of type S (schwer), M (mittel) and L (leicht), upper half."
        extends WallBaseDataDefinition(
          n(min=1) = 2 "Number of wall layers",
          d={0.02,0.06} "Thickness of wall layers",
          rho={120,2000} "Density of wall layers",
          lambda={0.055,1.4} "Thermal conductivity of wall layers",
          c={1030,1000} "Specific heat capacity of wall layers",
          eps=0.95 "Emissivity of inner wall surface");
        annotation (Documentation(revisions="<html>
<p><ul>
<li><i>September 5, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
<li><i>August 15, 2011</i> by Ana Constantin:<br/>implemented</li>
</ul></p>
</html>",
    info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Wall definition according to WSchV 1984. For detailed wall type see above. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars5.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>port_a</code>(outside), the last element represents the layer connected to <code>port_b</code>(surface facing the room). </p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a></p>
<p>Norm: </p>
<ul>
<li>W&auml;rmeschutzverordnung 1984. 1984</li>
</ul>
</html>"));
    end FLcellar_WSchV1984_SML_upHalf;
    end Floor;

    package Ceiling
          extends Modelica.Icons.Package;

    record CEpartition_WSchV1984_SM_loHalf
        "Ceiling partition after WSchV1984, for building of type S (schwer) and M (mittel), lower half"
        extends WallBaseDataDefinition(
          n(min=1) = 3 "Number of wall layers",
          d={0.02,0.16,0.015} "Thickness of wall layers",
          rho={120,2300,1200} "Density of wall layers",
          lambda={0.055,2.3,0.51} "Thermal conductivity of wall layers",
          c={1030,1000,1000} "Specific heat capacity of wall layers",
          eps=0.95 "Emissivity of inner wall surface");
        annotation (Documentation(revisions="<html>
<p><ul>
<li><i>September 5, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
<li><i>August 15, 2011</i> by Ana Constantin:<br/>implemented</li>
</ul></p>
</html>",
    info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Wall definition according to WSchV 1984. For detailed wall type see above. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars5.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>port_a</code>(outside), the last element represents the layer connected to <code>port_b</code>(surface facing the room). </p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a></p>
<p>Norm: </p>
<ul>
<li>W&auml;rmeschutzverordnung 1984. 1984</li>
</ul>
</html>"));
    end CEpartition_WSchV1984_SM_loHalf;

    record CEpartition_WSchV1984_L_loHalf
        "Ceiling partition after WSchV1984, for building of type L (leicht), lower half"
      // New Walls for Dymola 2012, the same number of layers as other mass clases
        extends WallBaseDataDefinition(
          n(min=1) = 3 "Number of wall layers",
          d={0.04,0.16,0.0275} "Thickness of wall layers",
          rho={510,93,1018.2} "Density of wall layers",
          lambda={0.084,0.73,0.346} "Thermal conductivity of wall layers",
          c={1621,1593,1000} "Specific heat capacity of wall layers",
          eps=0.95 "Emissivity of inner wall surface");

    /*      n(min=1) = 5 "Number of wall layers",
      d={0.02,0.02,0.16,0.0125,0.015} "Thickness of wall layers",
      rho={120,900,93,800,1200} "Density of wall layers",
      lambda={0.055,0.18,0.73,0.25,0.51} "Thermal conductivity of wall layers",
      c={1030,1700,1593,1000,1000} "Specific heat capacity of wall layers",
      eps=0.95 "Emissivity of inner wall surface");
*/

        annotation (Documentation(revisions="<html>
<p><ul>
<li><i>September 5, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
<li><i>August 15, 2011</i> by Ana Constantin:<br/>implemented</li>
</ul></p>
</html>",
    info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Wall definition according to WSchV 1984. For detailed wall type see above. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars5.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>port_a</code>(outside), the last element represents the layer connected to <code>port_b</code>(surface facing the room). </p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a></p>
<p>Norm: </p>
<ul>
<li>W&auml;rmeschutzverordnung 1984. 1984</li>
</ul>
</html>"));
    end CEpartition_WSchV1984_L_loHalf;

    record CEattic_WSchV1984_SML_loHalf
        "Ceiling towards attic after WSchV1984, for building of type S (schwer), M (mittel) and L (leicht), lower half"
        extends WallBaseDataDefinition(
          n(min=1) = 3 "Number of wall layers",
          d={0.08,0.0125,0.015} "Thickness of wall layers",
          rho={155,800,1200} "Density of wall layers",
          lambda={0.09,0.25,0.51} "Thermal conductivity of wall layers",
          c={1367,1000,1000} "Specific heat capacity of wall layers",
          eps=0.95 "Emissivity of inner wall surface");
        annotation (Documentation(revisions="<html>
<p><ul>
<li><i>September 5, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
<li><i>August 15, 2011</i> by Ana Constantin:<br/>implemented</li>
</ul></p>
</html>",
    info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Wall definition according to WSchV 1984. For detailed wall type see above. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars5.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>port_a</code>(outside), the last element represents the layer connected to <code>port_b</code>(surface facing the room). </p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a></p>
<p>Norm: </p>
<ul>
<li>W&auml;rmeschutzverordnung 1984. 1984</li>
</ul>
</html>"));
    end CEattic_WSchV1984_SML_loHalf;

    record CEcellar_WSchV1984_SML_loHalf
        "Ceiling cellar after WSchV1984, for building of type S (schwer), M (mittel) and L (leicht), lower half"
        extends WallBaseDataDefinition(
          n(min=1) = 3 "Number of wall layers",
          d={0.02,0.16,0.02} "Thickness of wall layers",
          rho={120,2300,120} "Density of wall layers",
          lambda={0.055,2.3,0.055} "Thermal conductivity of wall layers",
          c={1030,1000,1030} "Specific heat capacity of wall layers",
          eps=0.95 "Emissivity of inner wall surface");
        annotation (Documentation(revisions="<html>
<p><ul>
<li><i>September 5, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
<li><i>August 15, 2011</i> by Ana Constantin:<br/>implemented</li>
</ul></p>
</html>",
    info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Wall definition according to WSchV 1984. For detailed wall type see above. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars5.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>port_a</code>(outside), the last element represents the layer connected to <code>port_b</code>(surface facing the room). </p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a></p>
<p>Norm: </p>
<ul>
<li>W&auml;rmeschutzverordnung 1984. 1984</li>
</ul>
</html>"));
    end CEcellar_WSchV1984_SML_loHalf;

    record ROsaddleAttic_WSchV1984_SML
        "Saddle roof in attic after WSchV1984, for building of type S (schwer), M (mittel) and L (leicht)"
        extends WallBaseDataDefinition(
          n(min=1) = 1 "Number of wall layers",
          d={0.18} "Thickness of wall layers",
          rho={160} "Density of wall layers",
          lambda={0.084} "Thermal conductivity of wall layers",
          c={1358} "Specific heat capacity of wall layers",
          eps=0.95 "Emissivity of inner wall surface");
        annotation (Documentation(revisions="<html>
<p><ul>
<li><i>September 5, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
<li><i>August 15, 2011</i> by Ana Constantin:<br/>implemented</li>
</ul></p>
</html>",
    info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Wall definition according to WSchV 1984. For detailed wall type see above. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars5.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>port_a</code>(outside), the last element represents the layer connected to <code>port_b</code>(surface facing the room). </p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a></p>
<p>Norm: </p>
<ul>
<li>W&auml;rmeschutzverordnung 1984. 1984</li>
</ul>
</html>"));
    end ROsaddleAttic_WSchV1984_SML;

    record ROsaddleRoom_WSchV1984_SML
        "Saddle roof in room after WSchV1984, for building of type S (schwer), M (mittel) and L (leicht)"
        extends WallBaseDataDefinition(
          n(min=1) = 3 "Number of wall layers",
          d={0.18,0.0125,0.015} "Thickness of wall layers",
          rho={160,800,1200} "Density of wall layers",
          lambda={0.084,0.25,0.51} "Thermal conductivity of wall layers",
          c={1358,1000,1000} "Specific heat capacity of wall layers",
          eps=0.95 "Emissivity of inner wall surface");
        annotation (Documentation(revisions="<html>
<p><ul>
<li><i>September 5, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
<li><i>August 15, 2011</i> by Ana Constantin:<br/>implemented</li>
</ul></p>
</html>",
    info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Wall definition according to WSchV 1984. For detailed wall type see above. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars5.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>port_a</code>(outside), the last element represents the layer connected to <code>port_b</code>(surface facing the room). </p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a></p>
<p>Norm: </p>
<ul>
<li>W&auml;rmeschutzverordnung 1984. 1984</li>
</ul>
</html>"));
    end ROsaddleRoom_WSchV1984_SML;
    end Ceiling;
  end WSchV1984;

  package WSchV1995
        extends Modelica.Icons.Package;

    package OW
          extends Modelica.Icons.Package;

      record OW_WSchV1995_S
        "outer wall after WSchV1995, for building of type S (schwer)"
        extends WallBaseDataDefinition(
          n(min=1) = 4 "Number of wall layers",
          d={0.05,0.06,0.175,0.015} "Thickness of wall layers",
          rho={1800,120,1400,1200} "Density of wall layers",
          lambda={1,0.04,0.7,0.51} "Thermal conductivity of wall layers",
          c={1000,1030,1000,1000} "Specific heat capacity of wall layers",
          eps=0.95 "Emissivity of inner wall surface");
        annotation (Documentation(revisions="<html>
<p><ul>
<li><i>September 5, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
<li><i>August 15, 2011</i> by Ana Constantin:<br/>implemented</li>
</ul></p>
</html>", info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Wall definition according to WSchV 1995. For detailed wall type see above. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars5.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>port_a</code>(outside), the last element represents the layer connected to <code>port_b</code>(surface facing the room). </p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a></p>
<p>Norm: </p>
<ul>
<li>W&auml;rmeschutzverordnung 1995. 1995</li>
</ul>
</html>"));
      end OW_WSchV1995_S;

      record OW_WSchV1995_M
        "outer wall after WSchV1995, for building of type M (mittel)"
        extends WallBaseDataDefinition(
          n(min=1) = 4 "Number of wall layers",
          d={0.05,0.04,0.18,0.015} "Thickness of wall layers",
          rho={1800,120,700,1200} "Density of wall layers",
          lambda={1,0.04,0.21,0.51} "Thermal conductivity of wall layers",
          c={1000,1030,1000,1000} "Specific heat capacity of wall layers",
          eps=0.95 "Emissivity of inner wall surface");
        annotation (Documentation(revisions="<html>
<p><ul>
<li><i>September 5, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
<li><i>August 15, 2011</i> by Ana Constantin:<br/>implemented</li>
</ul></p>
</html>", info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Wall definition according to WSchV 1995. For detailed wall type see above. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars5.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>port_a</code>(outside), the last element represents the layer connected to <code>port_b</code>(surface facing the room). </p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a></p>
<p>Norm: </p>
<ul>
<li>W&auml;rmeschutzverordnung 1995. 1995</li>
</ul>
</html>"));
      end OW_WSchV1995_M;

      record OW_WSchV1995_L
        "outer wall after WSchV1995, for building of type L (leicht)"
        // New Walls for Dymola 2012, the same number of layers as other mass clases
        extends WallBaseDataDefinition(
          n(min=1) = 4 "Number of wall layers",
          d={0.03,0.02,0.18,0.0275} "Thickness of wall layers",
          rho={1800,600,138,1018.2} "Density of wall layers",
          lambda={1,0.14,0.105,0.346} "Thermal conductivity of wall layers",
          c={1000,1700,1411,1000} "Specific heat capacity of wall layers",
          eps=0.95 "Emissivity of inner wall surface");

      /*    n(min=1) = 5 "Number of wall layers",
    d={0.03,0.02,0.18,0.0125,0.015} "Thickness of wall layers",
    rho={1800,600,138,800,1200} "Density of wall layers",
    lambda={1,0.14,0.105,0.25,0.51} "Thermal conductivity of wall layers",
    c={1000,1700,1411,1000,1000} "Specific heat capacity of wall layers",
    eps=0.95 "Emissivity of inner wall surface");
    */
        annotation (Documentation(revisions="<html>
<p><ul>
<li><i>September 5, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
<li><i>August 15, 2011</i> by Ana Constantin:<br/>implemented</li>
</ul></p>
</html>", info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Wall definition according to WSchV 1995. For detailed wall type see above. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars5.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>port_a</code>(outside), the last element represents the layer connected to <code>port_b</code>(surface facing the room). </p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a></p>
<p>Norm: </p>
<ul>
<li>W&auml;rmeschutzverordnung 1995. 1995</li>
</ul>
</html>"));
      end OW_WSchV1995_L;
    end OW;

    package IW
          extends Modelica.Icons.Package;

      record IWsimple_WSchV1995_S_half
        "Inner wall simple after WSchV1995, for building of type S (schwer), only half"
        extends WallBaseDataDefinition(
          n(min=1) = 2 "Number of wall layers",
          d={0.0575,0.015} "Thickness of wall layers",
          rho={1400,1200} "Density of wall layers",
          lambda={0.7,0.51} "Thermal conductivity of wall layers",
          c={1000,1000} "Specific heat capacity of wall layers",
          eps=0.95 "Emissivity of inner wall surface");
        annotation (Documentation(revisions="<html>
<p><ul>
<li><i>September 5, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
<li><i>August 15, 2011</i> by Ana Constantin:<br/>implemented</li>
</ul></p>
</html>", info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Wall definition according to WSchV 1995. For detailed wall type see above. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars5.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>port_a</code>(outside), the last element represents the layer connected to <code>port_b</code>(surface facing the room). </p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a></p>
<p>Norm: </p>
<ul>
<li>W&auml;rmeschutzverordnung 1995. 1995</li>
</ul>
</html>"));
      end IWsimple_WSchV1995_S_half;

      record IWload_WSchV1995_S_half
        "Inner wall load-bearing after WSchV1995, for building of type S (schwer), only half"
        extends WallBaseDataDefinition(
          n(min=1) = 2 "Number of wall layers",
          d={0.0875,0.015} "Thickness of wall layers",
          rho={1400,1200} "Density of wall layers",
          lambda={0.7,0.51} "Thermal conductivity of wall layers",
          c={1000,1000} "Specific heat capacity of wall layers",
          eps=0.95 "Emissivity of inner wall surface");
        annotation (Documentation(revisions="<html>
<p><ul>
<li><i>September 5, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
<li><i>August 15, 2011</i> by Ana Constantin:<br/>implemented</li>
</ul></p>
</html>", info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Wall definition according to WSchV 1995. For detailed wall type see above. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars5.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>port_a</code>(outside), the last element represents the layer connected to <code>port_b</code>(surface facing the room). </p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a></p>
<p>Norm: </p>
<ul>
<li>W&auml;rmeschutzverordnung 1995. 1995</li>
</ul>
</html>"));
      end IWload_WSchV1995_S_half;

      record IWneighbour_WSchV1995_S_half
        "Inner wall towards neighbour after WSchV1995, for building of type S (schwer), only half"
        extends WallBaseDataDefinition(
          n(min=1) = 3 "Number of wall layers",
          d={0.02,0.175,0.015} "Thickness of wall layers",
          rho={120,1400,1200} "Density of wall layers",
          lambda={0.055,0.7,0.51} "Thermal conductivity of wall layers",
          c={1030,1000,1000} "Specific heat capacity of wall layers",
          eps=0.95 "Emissivity of inner wall surface");
        annotation (Documentation(revisions="<html>
<p><ul>
<li><i>September 5, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
<li><i>August 15, 2011</i> by Ana Constantin:<br/>implemented</li>
</ul></p>
</html>", info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Wall definition according to WSchV 1995. For detailed wall type see above. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars5.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>port_a</code>(outside), the last element represents the layer connected to <code>port_b</code>(surface facing the room). </p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a></p>
<p>Norm: </p>
<ul>
<li>W&auml;rmeschutzverordnung 1995. 1995</li>
</ul>
</html>"));
      end IWneighbour_WSchV1995_S_half;

      record IWsimple_WSchV1995_M_half
        "Inner wall simple after WSchV1995, for building of type M (mittel), only half"
        extends WallBaseDataDefinition(
          n(min=1) = 2 "Number of wall layers",
          d={0.0575,0.015} "Thickness of wall layers",
          rho={1000,1200} "Density of wall layers",
          lambda={0.31,0.51} "Thermal conductivity of wall layers",
          c={1000,1000} "Specific heat capacity of wall layers",
          eps=0.95 "Emissivity of inner wall surface");
        annotation (Documentation(revisions="<html>
<p><ul>
<li><i>September 5, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
<li><i>August 15, 2011</i> by Ana Constantin:<br/>implemented</li>
</ul></p>
</html>", info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Wall definition according to WSchV 1995. For detailed wall type see above. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars5.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>port_a</code>(outside), the last element represents the layer connected to <code>port_b</code>(surface facing the room). </p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a></p>
<p>Norm: </p>
<ul>
<li>W&auml;rmeschutzverordnung 1995. 1995</li>
</ul>
</html>"));
      end IWsimple_WSchV1995_M_half;

      record IWload_WSchV1995_M_half
        "Inner wall load-bearing after WSchV1995, for building of type M (schwer), only half"
        extends WallBaseDataDefinition(
          n(min=1) = 2 "Number of wall layers",
          d={0.0875,0.015} "Thickness of wall layers",
          rho={1000,1200} "Density of wall layers",
          lambda={0.31,0.51} "Thermal conductivity of wall layers",
          c={1000,1000} "Specific heat capacity of wall layers",
          eps=0.95 "Emissivity of inner wall surface");
        annotation (Documentation(revisions="<html>
<p><ul>
<li><i>September 5, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
<li><i>August 15, 2011</i> by Ana Constantin:<br/>implemented</li>
</ul></p>
</html>", info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Wall definition according to WSchV 1995. For detailed wall type see above. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars5.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>port_a</code>(outside), the last element represents the layer connected to <code>port_b</code>(surface facing the room). </p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a></p>
<p>Norm: </p>
<ul>
<li>W&auml;rmeschutzverordnung 1995. 1995</li>
</ul>
</html>"));
      end IWload_WSchV1995_M_half;

      record IWneighbour_WSchV1995_M_half
        "Inner wall towards neighbour after WSchV1995, for building of type S (mitel), only half"
        extends WallBaseDataDefinition(
          n(min=1) = 3 "Number of wall layers",
          d={0.02,0.175,0.015} "Thickness of wall layers",
          rho={120,1000,1200} "Density of wall layers",
          lambda={0.045,0.31,0.51} "Thermal conductivity of wall layers",
          c={1030,1000,1000} "Specific heat capacity of wall layers",
          eps=0.95 "Emissivity of inner wall surface");
        annotation (Documentation(revisions="<html>
<p><ul>
<li><i>September 5, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
<li><i>August 15, 2011</i> by Ana Constantin:<br/>implemented</li>
</ul></p>
</html>", info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Wall definition according to WSchV 1995. For detailed wall type see above. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars5.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>port_a</code>(outside), the last element represents the layer connected to <code>port_b</code>(surface facing the room). </p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a></p>
<p>Norm: </p>
<ul>
<li>W&auml;rmeschutzverordnung 1995. 1995</li>
</ul>
</html>"));
      end IWneighbour_WSchV1995_M_half;

      record IWsimple_WSchV1995_L_half
        "Inner wall simple after WSchV1995, for building of type L (leicht), only half"
        // New Walls for Dymola 2012, the same number of layers as other mass clases
        extends WallBaseDataDefinition(
          n(min=1) = 2 "Number of wall layers",
          d={0.05,0.0275} "Thickness of wall layers",
          rho={93,1018.2} "Density of wall layers",
          lambda={0.44,0.346} "Thermal conductivity of wall layers",
          c={1593,1000} "Specific heat capacity of wall layers",
          eps=0.95 "Emissivity of inner wall surface");

      /*    n(min=1) = 3 "Number of wall layers",
    d={0.05,0.0125,0.015} "Thickness of wall layers",
    rho={93,800,1200} "Density of wall layers",
    lambda={0.44,0.25,0.51} "Thermal conductivity of wall layers",
    c={1593,1000,1000} "Specific heat capacity of wall layers",
    eps=0.95 "Emissivity of inner wall surface"); 
*/
        annotation (Documentation(revisions="<html>
<p><ul>
<li><i>September 5, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
<li><i>August 15, 2011</i> by Ana Constantin:<br/>implemented</li>
</ul></p>
</html>", info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Wall definition according to WSchV 1995. For detailed wall type see above. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars5.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>port_a</code>(outside), the last element represents the layer connected to <code>port_b</code>(surface facing the room). </p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a></p>
<p>Norm: </p>
<ul>
<li>W&auml;rmeschutzverordnung 1995. 1995</li>
</ul>
</html>"));
      end IWsimple_WSchV1995_L_half;

      record IWload_WSchV1995_L_half
        "Inner wall load-bearing after WSchV1995, for building of type L (leicht), only half"
        // New Walls for Dymola 2012, the same number of layers as other mass clases
        extends WallBaseDataDefinition(
          n(min=1) = 2 "Number of wall layers",
          d={0.09,0.0275} "Thickness of wall layers",
          rho={93,1018.2} "Density of wall layers",
          lambda={0.78,0.346} "Thermal conductivity of wall layers",
          c={1593,1000} "Specific heat capacity of wall layers",
          eps=0.95 "Emissivity of inner wall surface");

      /*    n(min=1) = 3 "Number of wall layers",
    d={0.09,0.0125,0.015} "Thickness of wall layers",
    rho={93,800,1200} "Density of wall layers",
    lambda={0.78,0.25,0.51} "Thermal conductivity of wall layers",
    c={1593,1000,1000} "Specific heat capacity of wall layers",
    eps=0.95 "Emissivity of inner wall surface");
*/
        annotation (Documentation(revisions="<html>
<p><ul>
<li><i>September 5, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
<li><i>August 15, 2011</i> by Ana Constantin:<br/>implemented</li>
</ul></p>
</html>", info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Wall definition according to WSchV 1995. For detailed wall type see above. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars5.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>port_a</code>(outside), the last element represents the layer connected to <code>port_b</code>(surface facing the room). </p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a></p>
<p>Norm: </p>
<ul>
<li>W&auml;rmeschutzverordnung 1995. 1995</li>
</ul>
</html>"));
      end IWload_WSchV1995_L_half;

      record IWneighbour_WSchV1995_L_half
        "Inner wall towards neighbour after WSchV1995, for building of type L (leicht), only half"
        // New Walls for Dymola 2012, the same number of layers as other mass clases
        extends WallBaseDataDefinition(
          n(min=1) = 3 "Number of wall layers",
          d={0.0325,0.18,0.0275} "Thickness of wall layers",
          rho={382,93,1018.2} "Density of wall layers",
          lambda={0.066,0.78,0.346} "Thermal conductivity of wall layers",
          c={1006,1593,1000} "Specific heat capacity of wall layers",
          eps=0.95 "Emissivity of inner wall surface");

      /*    n(min=1) = 5 "Number of wall layers",
    d={0.02,0.0125,0.18,0.0125,0.015} "Thickness of wall layers",
    rho={120,800,93,800,1200} "Density of wall layers",
    lambda={0.045,0.25,0.78,0.25,0.51} "Thermal conductivity of wall layers",
    c={1030,1000,1593,1000,1000} "Specific heat capacity of wall layers",
    eps=0.95 "Emissivity of inner wall surface");
*/
        annotation (Documentation(revisions="<html>
<p><ul>
<li><i>September 5, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
<li><i>August 15, 2011</i> by Ana Constantin:<br/>implemented</li>
</ul></p>
</html>", info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Wall definition according to WSchV 1995. For detailed wall type see above. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars5.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>port_a</code>(outside), the last element represents the layer connected to <code>port_b</code>(surface facing the room). </p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a></p>
<p>Norm: </p>
<ul>
<li>W&auml;rmeschutzverordnung 1995. 1995</li>
</ul>
</html>"));
      end IWneighbour_WSchV1995_L_half;
    end IW;

    package Floor
          extends Modelica.Icons.Package;

    record FLground_WSchV1995_SML
        "Floor towards ground after WSchV1995, for building of type S (schwer), M (mittel) and L (leicht)"
        extends WallBaseDataDefinition(
          n(min=1) = 4 "Number of wall layers",
          d={0.04,0.25,0.04,0.06} "Thickness of wall layers",
          rho={100,2300,120,2000} "Density of wall layers",
          lambda={0.05,2.3,0.045,1.4} "Thermal conductivity of wall layers",
          c={1000,1000,1030,1000} "Specific heat capacity of wall layers",
          eps=0.95 "Emissivity of inner wall surface");
        annotation (Documentation(revisions="<html>
<p><ul>
<li><i>September 5, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
<li><i>August 15, 2011</i> by Ana Constantin:<br/>implemented</li>
</ul></p>
</html>",
    info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Wall definition according to WSchV 1995. For detailed wall type see above. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars5.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>port_a</code>(outside), the last element represents the layer connected to <code>port_b</code>(surface facing the room). </p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a></p>
<p>Norm: </p>
<ul>
<li>W&auml;rmeschutzverordnung 1995. 1995</li>
</ul>
</html>"));
    end FLground_WSchV1995_SML;

    record FLpartition_WSchV1995_SM_upHalf
        "Floor partition after WSchV1995, for building of type S (schwer) and M (mittel), upper half"
        extends WallBaseDataDefinition(
          n(min=1) = 2 "Number of wall layers",
          d={0.02,0.06} "Thickness of wall layers",
          rho={120,2000} "Density of wall layers",
          lambda={0.045,1.4} "Thermal conductivity of wall layers",
          c={1030,1000} "Specific heat capacity of wall layers",
          eps=0.95 "Emissivity of inner wall surface");
        annotation (Documentation(revisions="<html>
<p><ul>
<li><i>September 5, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
<li><i>August 15, 2011</i> by Ana Constantin:<br/>implemented</li>
</ul></p>
</html>",
    info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Wall definition according to WSchV 1995. For detailed wall type see above. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars5.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>port_a</code>(outside), the last element represents the layer connected to <code>port_b</code>(surface facing the room). </p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a></p>
<p>Norm: </p>
<ul>
<li>W&auml;rmeschutzverordnung 1995. 1995</li>
</ul>
</html>"));
    end FLpartition_WSchV1995_SM_upHalf;

    record FLpartition_WSchV1995_L_upHalf
        "Floor partition after WSchV1995, for building of typeL (leicht), upper half"
        extends WallBaseDataDefinition(
          n(min=1) = 2 "Number of wall layers",
          d={0.02,0.06} "Thickness of wall layers",
          rho={120,2000} "Density of wall layers",
          lambda={0.045,1.4} "Thermal conductivity of wall layers",
          c={1030,1000} "Specific heat capacity of wall layers",
          eps=0.95 "Emissivity of inner wall surface");
        annotation (Documentation(revisions="<html>
<p><ul>
<li><i>September 5, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
<li><i>August 15, 2011</i> by Ana Constantin:<br/>implemented</li>
</ul></p>
</html>",
    info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Wall definition according to WSchV 1995. For detailed wall type see above. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars5.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>port_a</code>(outside), the last element represents the layer connected to <code>port_b</code>(surface facing the room). </p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a></p>
<p>Norm: </p>
<ul>
<li>W&auml;rmeschutzverordnung 1995. 1995</li>
</ul>
</html>"));
    end FLpartition_WSchV1995_L_upHalf;

    record FLcellar_WSchV1995_SML_upHalf
        "Floor towards cellar after WSchV1995, for building of type S (schwer), M (mittel) and L (leicht), upper half."
        extends WallBaseDataDefinition(
          n(min=1) = 2 "Number of wall layers",
          d={0.02,0.06} "Thickness of wall layers",
          rho={120,2000} "Density of wall layers",
          lambda={0.04,1.4} "Thermal conductivity of wall layers",
          c={1030,1000} "Specific heat capacity of wall layers",
          eps=0.95 "Emissivity of inner wall surface");
        annotation (Documentation(revisions="<html>
<p><ul>
<li><i>September 5, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
<li><i>August 15, 2011</i> by Ana Constantin:<br/>implemented</li>
</ul></p>
</html>",
    info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Wall definition according to WSchV 1995. For detailed wall type see above. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars5.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>port_a</code>(outside), the last element represents the layer connected to <code>port_b</code>(surface facing the room). </p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a></p>
<p>Norm: </p>
<ul>
<li>W&auml;rmeschutzverordnung 1995. 1995</li>
</ul>
</html>"));
    end FLcellar_WSchV1995_SML_upHalf;
    end Floor;

    package Ceiling
          extends Modelica.Icons.Package;

    record CEpartition_WSchV1995_SM_loHalf
        "Ceiling partition after WSchV1995, for building of type S (schwer) and M (mittel), lower half"
        extends WallBaseDataDefinition(
          n(min=1) = 3 "Number of wall layers",
          d={0.02,0.16,0.015} "Thickness of wall layers",
          rho={120,2300,1200} "Density of wall layers",
          lambda={0.045,2.3,0.51} "Thermal conductivity of wall layers",
          c={1030,1000,1000} "Specific heat capacity of wall layers",
          eps=0.95 "Emissivity of inner wall surface");
        annotation (Documentation(revisions="<html>
<p><ul>
<li><i>September 5, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
<li><i>August 15, 2011</i> by Ana Constantin:<br/>implemented</li>
</ul></p>
</html>",
    info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Wall definition according to WSchV 1995. For detailed wall type see above. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars5.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>port_a</code>(outside), the last element represents the layer connected to <code>port_b</code>(surface facing the room). </p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a></p>
<p>Norm: </p>
<ul>
<li>W&auml;rmeschutzverordnung 1995. 1995</li>
</ul>
</html>"));
    end CEpartition_WSchV1995_SM_loHalf;

    record CEpartition_WSchV1995_L_loHalf
        "Ceiling partition after WSchV1995, for building of type L (leicht), lower half"
      // New Walls for Dymola 2012, the same number of layers as other mass clases
        extends WallBaseDataDefinition(
          n(min=1) = 3 "Number of wall layers",
          d={0.04,0.16,0.0275} "Thickness of wall layers",
          rho={360,93,1018.2} "Density of wall layers",
          lambda={0.068,0.53,0.346} "Thermal conductivity of wall layers",
          c={1588,1593,1000} "Specific heat capacity of wall layers",
          eps=0.95 "Emissivity of inner wall surface");

    /*    n(min=1) = 5 "Number of wall layers",
      d={0.02,0.02,0.16,0.0125,0.015} "Thickness of wall layers",
      rho={120,600,93,800,1200} "Density of wall layers",
      lambda={0.045,0.14,0.53,0.25,0.51} "Thermal conductivity of wall layers",
      c={1030,1700,1593,1000,1000} "Specific heat capacity of wall layers",
      eps=0.95 "Emissivity of inner wall surface");
*/

        annotation (Documentation(revisions="<html>
<p><ul>
<li><i>September 5, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
<li><i>August 15, 2011</i> by Ana Constantin:<br/>implemented</li>
</ul></p>
</html>",
    info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Wall definition according to WSchV 1995. For detailed wall type see above. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars5.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>port_a</code>(outside), the last element represents the layer connected to <code>port_b</code>(surface facing the room). </p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a></p>
<p>Norm: </p>
<ul>
<li>W&auml;rmeschutzverordnung 1995. 1995</li>
</ul>
</html>"));
    end CEpartition_WSchV1995_L_loHalf;

    record CEattic_WSchV1995_SML_loHalf
        "Ceiling towards attic after WSchV1995, for building of type S (schwer), M (mittel) and L (leicht), lower half"
        extends WallBaseDataDefinition(
          n(min=1) = 3 "Number of wall layers",
          d={0.08,0.0125,0.015} "Thickness of wall layers",
          rho={194,800,1200} "Density of wall layers",
          lambda={0.054,0.25,0.51} "Thermal conductivity of wall layers",
          c={1301,1000,1000} "Specific heat capacity of wall layers",
          eps=0.95 "Emissivity of inner wall surface");
        annotation (Documentation(revisions="<html>
<p><ul>
<li><i>September 5, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
<li><i>August 15, 2011</i> by Ana Constantin:<br/>implemented</li>
</ul></p>
</html>",
    info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Wall definition according to WSchV 1995. For detailed wall type see above. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars5.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>port_a</code>(outside), the last element represents the layer connected to <code>port_b</code>(surface facing the room). </p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a></p>
<p>Norm: </p>
<ul>
<li>W&auml;rmeschutzverordnung 1995. 1995</li>
</ul>
</html>"));
    end CEattic_WSchV1995_SML_loHalf;

    record CEcellar_WSchV1995_SML_loHalf
        "Ceiling cellar after WSchV1995, for building of type S (schwer), M (mittel) and L (leicht), lower half"
        extends WallBaseDataDefinition(
          n(min=1) = 3 "Number of wall layers",
          d={0.02,0.16,0.02} "Thickness of wall layers",
          rho={120,2300,120} "Density of wall layers",
          lambda={0.04,2.3,0.035} "Thermal conductivity of wall layers",
          c={1030,1000,1030} "Specific heat capacity of wall layers",
          eps=0.95 "Emissivity of inner wall surface");
        annotation (Documentation(revisions="<html>
<p><ul>
<li><i>September 5, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
<li><i>August 15, 2011</i> by Ana Constantin:<br/>implemented</li>
</ul></p>
</html>",
    info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Wall definition according to WSchV 1995. For detailed wall type see above. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars5.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>port_a</code>(outside), the last element represents the layer connected to <code>port_b</code>(surface facing the room). </p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a></p>
<p>Norm: </p>
<ul>
<li>W&auml;rmeschutzverordnung 1995. 1995</li>
</ul>
</html>"));
    end CEcellar_WSchV1995_SML_loHalf;

    record ROsaddleAttic_WSchV1995_SML
        "Saddle roof in attic after WSchV1995, for building of type S (schwer), M (mittel) and L (leicht)"
        extends WallBaseDataDefinition(
          n(min=1) = 1 "Number of wall layers",
          d={0.18} "Thickness of wall layers",
          rho={194} "Density of wall layers",
          lambda={0.058} "Thermal conductivity of wall layers",
          c={1301} "Specific heat capacity of wall layers",
          eps=0.95 "Emissivity of inner wall surface");
        annotation (Documentation(revisions="<html>
<p><ul>
<li><i>September 5, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
<li><i>August 15, 2011</i> by Ana Constantin:<br/>implemented</li>
</ul></p>
</html>",
    info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Wall definition according to WSchV 1995. For detailed wall type see above. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars5.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>port_a</code>(outside), the last element represents the layer connected to <code>port_b</code>(surface facing the room). </p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a></p>
<p>Norm: </p>
<ul>
<li>W&auml;rmeschutzverordnung 1995. 1995</li>
</ul>
</html>"));
    end ROsaddleAttic_WSchV1995_SML;

    record ROsaddleRoom_WSchV1995_SML
        "Saddle roof in room after WSchV1995, for building of type S (schwer), M (mittel) and L (leicht)"
        extends WallBaseDataDefinition(
          n(min=1) = 3 "Number of wall layers",
          d={0.18,0.0125,0.015} "Thickness of wall layers",
          rho={194,800,1200} "Density of wall layers",
          lambda={0.058,0.25,0.51} "Thermal conductivity of wall layers",
          c={1301,1000,1000} "Specific heat capacity of wall layers",
          eps=0.95 "Emissivity of inner wall surface");
        annotation (Documentation(revisions="<html>
<p><ul>
<li><i>September 5, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
<li><i>August 15, 2011</i> by Ana Constantin:<br/>implemented</li>
</ul></p>
</html>",
    info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Wall definition according to WSchV 1995. For detailed wall type see above. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars5.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>port_a</code>(outside), the last element represents the layer connected to <code>port_b</code>(surface facing the room). </p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a></p>
<p>Norm: </p>
<ul>
<li>W&auml;rmeschutzverordnung 1995. 1995</li>
</ul>
</html>"));
    end ROsaddleRoom_WSchV1995_SML;
    end Ceiling;
  end WSchV1995;

  package EnEV2002
        extends Modelica.Icons.Package;

    package OW
          extends Modelica.Icons.Package;

      record OW_EnEV2002_S
        "outer wall after EnEV 2002, for building of type S (schwer)"
        extends WallBaseDataDefinition(
          n(min=1) = 4 "Number of wall layers",
          d={0.05,0.06,0.175,0.015} "Thickness of wall layers",
          rho={1800,120,1200,1200} "Density of wall layers",
          lambda={1,0.035,0.56,0.51} "Thermal conductivity of wall layers",
          c={1000,1030,1000,1000} "Specific heat capacity of wall layers",
          eps=0.95 "Emissivity of inner wall surface");

        annotation (Documentation(revisions="<html>
<p><ul>
<li><i>September 5, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
<li><i>Juni 1, 2011</i> by Ana Constantin:<br/>implemented</li>
</ul></p>
</html>", info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Wall definition according to EnEV 2002. For detailed wall type see above. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars5.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>port_a</code>(outside), the last element represents the layer connected to <code>port_b</code>(surface facing the room). </p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a></p>
<p>Norm: </p>
<ul>
<li>Energieeinsparverordnung 2002. 2002</li>
</ul>
</html>"));
      end OW_EnEV2002_S;

      record OW_EnEV2002_M
        "outer wall after EnEV 2002, for building of type M (mittel)"
        extends WallBaseDataDefinition(
          n(min=1) = 4 "Number of wall layers",
          d={0.05,0.04,0.175,0.015} "Thickness of wall layers",
          rho={1800,120,500,1200} "Density of wall layers",
          lambda={1,0.04,0.16,0.51} "Thermal conductivity of wall layers",
          c={1000,1030,1000,1000} "Specific heat capacity of wall layers",
          eps=0.95 "Emissivity of inner wall surface");
        annotation (Documentation(revisions="<html>
<p><ul>
<li><i>September 5, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
<li><i>Juni 1, 2011</i> by Ana Constantin:<br/>implemented</li>
</ul></p>
</html>", info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Wall definition according to EnEV 2002. For detailed wall type see above. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars5.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>port_a</code>(outside), the last element represents the layer connected to <code>port_b</code>(surface facing the room). </p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a></p>
<p>Norm: </p>
<ul>
<li>Energieeinsparverordnung 2002. 2002</li>
</ul>
</html>"));
      end OW_EnEV2002_M;

      record OW_EnEV2002_L
        "outer wall after EnEV 2002, for building of type L (leicht)"
        // New Walls for Dymola 2012, the same number of layers as other mass clases
        extends WallBaseDataDefinition(
          n(min=1) = 4 "Number of wall layers",
          d={0.03,0.02,0.18,0.0275} "Thickness of wall layers",
          rho={1800,300,138,1018.2} "Density of wall layers",
          lambda={1,0.1,0.097,0.346} "Thermal conductivity of wall layers",
          c={1000,1700,1411,1000} "Specific heat capacity of wall layers",
          eps=0.95 "Emissivity of inner wall surface");

      /*    n(min=1) = 5 "Number of wall layers",
    d={0.03,0.02,0.18,0.0125,0.015} "Thickness of wall layers",
    rho={1800,300,138,800,1200} "Density of wall layers",
    lambda={1,0.1,0.097,0.25,0.51} "Thermal conductivity of wall layers",
    c={1000,1700,1411,1000,1000} "Specific heat capacity of wall layers",
    eps=0.95 "Emissivity of inner wall surface");
*/
        annotation (Documentation(revisions="<html>
<p><ul>
<li><i>September 5, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
<li><i>Juni 1, 2011</i> by Ana Constantin:<br/>implemented</li>
</ul></p>
</html>", info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Wall definition according to EnEV 2002. For detailed wall type see above. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars5.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>port_a</code>(outside), the last element represents the layer connected to <code>port_b</code>(surface facing the room). </p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a></p>
<p>Norm: </p>
<ul>
<li>Energieeinsparverordnung 2002. 2002</li>
</ul>
</html>"));
      end OW_EnEV2002_L;
    end OW;

    package IW
          extends Modelica.Icons.Package;

      record IWsimple_EnEV2002_S_half
        "Inner wall simple after EnEV 2002, for building of type S (schwer), only half"
        extends WallBaseDataDefinition(
          n(min=1) = 2 "Number of wall layers",
          d={0.0575,0.015} "Thickness of wall layers",
          rho={1200,1200} "Density of wall layers",
          lambda={0.56,0.51} "Thermal conductivity of wall layers",
          c={1000,1000} "Specific heat capacity of wall layers",
          eps=0.95 "Emissivity of inner wall surface");
        annotation (Documentation(revisions="<html>
<p><ul>
<li><i>September 5, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
<li><i>Juni 1, 2011</i> by Ana Constantin:<br/>implemented</li>
</ul></p>
</html>", info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Wall definition according to EnEV 2002. For detailed wall type see above. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars5.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>port_a</code>(outside), the last element represents the layer connected to <code>port_b</code>(surface facing the room). </p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a></p>
<p>Norm: </p>
<ul>
<li>Energieeinsparverordnung 2002. 2002</li>
</ul>
</html>"));
      end IWsimple_EnEV2002_S_half;

      record IWload_EnEV2002_S_half
        "Inner wall load-bearing after EnEV 2002, for building of type S (schwer), only half"
        extends WallBaseDataDefinition(
          n(min=1) = 2 "Number of wall layers",
          d={0.0875,0.015} "Thickness of wall layers",
          rho={1200,1200} "Density of wall layers",
          lambda={0.56,0.51} "Thermal conductivity of wall layers",
          c={1000,1000} "Specific heat capacity of wall layers",
          eps=0.95 "Emissivity of inner wall surface");
        annotation (Documentation(revisions="<html>
<p><ul>
<li><i>September 5, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
<li><i>Juni 1, 2011</i> by Ana Constantin:<br/>implemented</li>
</ul></p>
</html>", info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Wall definition according to EnEV 2002. For detailed wall type see above. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars5.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>port_a</code>(outside), the last element represents the layer connected to <code>port_b</code>(surface facing the room). </p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a></p>
<p>Norm: </p>
<ul>
<li>Energieeinsparverordnung 2002. 2002</li>
</ul>
</html>"));
      end IWload_EnEV2002_S_half;

      record IWneighbour_EnEV2002_S_half
        "Inner wall towards neighbour after EnEV 2002, for building of type S (schwer), only half"
        extends WallBaseDataDefinition(
          n(min=1) = 3 "Number of wall layers",
          d={0.02,0.175,0.015} "Thickness of wall layers",
          rho={120,1200,1200} "Density of wall layers",
          lambda={0.035,0.56,0.51} "Thermal conductivity of wall layers",
          c={1030,1000,1000} "Specific heat capacity of wall layers",
          eps=0.95 "Emissivity of inner wall surface");
        annotation (Documentation(revisions="<html>
<p><ul>
<li><i>September 5, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
<li><i>Juni 1, 2011</i> by Ana Constantin:<br/>implemented</li>
</ul></p>
</html>", info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Wall definition according to EnEV 2002. For detailed wall type see above. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars5.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>port_a</code>(outside), the last element represents the layer connected to <code>port_b</code>(surface facing the room). </p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a></p>
<p>Norm: </p>
<ul>
<li>Energieeinsparverordnung 2002. 2002</li>
</ul>
</html>"));
      end IWneighbour_EnEV2002_S_half;

      record IWsimple_EnEV2002_M_half
        "Inner wall simple after EnEV, for building of type M (mittel), only half"
        extends WallBaseDataDefinition(
          n(min=1) = 2 "Number of wall layers",
          d={0.0575,0.015} "Thickness of wall layers",
          rho={1000,1200} "Density of wall layers",
          lambda={0.31,0.51} "Thermal conductivity of wall layers",
          c={1000,1000} "Specific heat capacity of wall layers",
          eps=0.95 "Emissivity of inner wall surface");
        annotation (Documentation(revisions="<html>
<p><ul>
<li><i>September 5, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
<li><i>Juni 1, 2011</i> by Ana Constantin:<br/>implemented</li>
</ul></p>
</html>", info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Wall definition according to EnEV 2002. For detailed wall type see above. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars5.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>port_a</code>(outside), the last element represents the layer connected to <code>port_b</code>(surface facing the room). </p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a></p>
<p>Norm: </p>
<ul>
<li>Energieeinsparverordnung 2002. 2002</li>
</ul>
</html>"));
      end IWsimple_EnEV2002_M_half;

      record IWload_EnEV2002_M_half
        "Inner wall load-bearing after EnEV 2002, for building of type M (schwer), only half"
        extends WallBaseDataDefinition(
          n(min=1) = 2 "Number of wall layers",
          d={0.0875,0.015} "Thickness of wall layers",
          rho={1000,1200} "Density of wall layers",
          lambda={0.31,0.51} "Thermal conductivity of wall layers",
          c={1000,1000} "Specific heat capacity of wall layers",
          eps=0.95 "Emissivity of inner wall surface");
        annotation (Documentation(revisions="<html>
<p><ul>
<li><i>September 5, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
<li><i>Juni 1, 2011</i> by Ana Constantin:<br/>implemented</li>
</ul></p>
</html>", info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Wall definition according to EnEV 2002. For detailed wall type see above. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars5.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>port_a</code>(outside), the last element represents the layer connected to <code>port_b</code>(surface facing the room). </p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a></p>
<p>Norm: </p>
<ul>
<li>Energieeinsparverordnung 2002. 2002</li>
</ul>
</html>"));
      end IWload_EnEV2002_M_half;

      record IWneighbour_EnEV2002_M_half
        "Inner wall towards neighbour after EnEV 2002, for building of type S (mitel), only half"
        extends WallBaseDataDefinition(
          n(min=1) = 3 "Number of wall layers",
          d={0.02,0.175,0.015} "Thickness of wall layers",
          rho={120,1000,1200} "Density of wall layers",
          lambda={0.035,0.31,0.51} "Thermal conductivity of wall layers",
          c={1030,1000,1000} "Specific heat capacity of wall layers",
          eps=0.95 "Emissivity of inner wall surface");
        annotation (Documentation(revisions="<html>
<p><ul>
<li><i>September 5, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
<li><i>Juni 1, 2011</i> by Ana Constantin:<br/>implemented</li>
</ul></p>
</html>", info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Wall definition according to EnEV 2002. For detailed wall type see above. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars5.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>port_a</code>(outside), the last element represents the layer connected to <code>port_b</code>(surface facing the room). </p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a></p>
<p>Norm: </p>
<ul>
<li>Energieeinsparverordnung 2002. 2002</li>
</ul>
</html>"));
      end IWneighbour_EnEV2002_M_half;

      record IWsimple_EnEV2002_L_half
        "Inner wall simple after EnEV, for building of type L (leicht), only half"
        // New Walls for Dymola 2012, the same number of layers as other mass clases
        extends WallBaseDataDefinition(
          n(min=1) = 2 "Number of wall layers",
          d={0.05,0.0275} "Thickness of wall layers",
          rho={93,1018.2} "Density of wall layers",
          lambda={0.44,0.346} "Thermal conductivity of wall layers",
          c={1593,1000} "Specific heat capacity of wall layers",
          eps=0.95 "Emissivity of inner wall surface");

      /*     n(min=1) = 3 "Number of wall layers",
    d={0.05,0.0125,0.015} "Thickness of wall layers",
    rho={93,800,1200} "Density of wall layers",
    lambda={0.44,0.25,0.51} "Thermal conductivity of wall layers",
    c={1593,1000,1000} "Specific heat capacity of wall layers",
    eps=0.95 "Emissivity of inner wall surface");
*/
        annotation (Documentation(revisions="<html>
<p><ul>
<li><i>September 5, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
<li><i>Juni 1, 2011</i> by Ana Constantin:<br/>implemented</li>
</ul></p>
</html>", info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Wall definition according to EnEV 2002. For detailed wall type see above. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars5.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>port_a</code>(outside), the last element represents the layer connected to <code>port_b</code>(surface facing the room). </p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a></p>
<p>Norm: </p>
<ul>
<li>Energieeinsparverordnung 2002. 2002</li>
</ul>
</html>"));
      end IWsimple_EnEV2002_L_half;

      record IWload_EnEV2002_L_half
        "Inner wall load-bearing after EnEV 2002, for building of type L (leicht), only half"
        // New Walls for Dymola 2012, the same number of layers as other mass clases
        extends WallBaseDataDefinition(
          n(min=1) = 2 "Number of wall layers",
          d={0.09,0.0275} "Thickness of wall layers",
          rho={93,1018.2} "Density of wall layers",
          lambda={0.78,0.346} "Thermal conductivity of wall layers",
          c={1593,1000} "Specific heat capacity of wall layers",
          eps=0.95 "Emissivity of inner wall surface");

      /*    n(min=1) = 3 "Number of wall layers",
    d={0.09,0.0125,0.015} "Thickness of wall layers",
    rho={93,800,1200} "Density of wall layers",
    lambda={0.78,0.25,0.51} "Thermal conductivity of wall layers",
    c={1593,1000,1000} "Specific heat capacity of wall layers",
    eps=0.95 "Emissivity of inner wall surface");
*/
        annotation (Documentation(revisions="<html>
<p><ul>
<li><i>September 5, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
<li><i>Juni 1, 2011</i> by Ana Constantin:<br/>implemented</li>
</ul></p>
</html>", info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Wall definition according to EnEV 2002. For detailed wall type see above. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars5.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>port_a</code>(outside), the last element represents the layer connected to <code>port_b</code>(surface facing the room). </p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a></p>
<p>Norm: </p>
<ul>
<li>Energieeinsparverordnung 2002. 2002</li>
</ul>
</html>"));
      end IWload_EnEV2002_L_half;

      record IWneighbour_EnEV2002_L_half
        "Inner wall towards neighbour after EnEV 2002, for building of type L (leicht), only half"
        // New Walls for Dymola 2012, the same number of layers as other mass clases
        extends WallBaseDataDefinition(
          n(min=1) = 3 "Number of wall layers",
          d={0.0325,0.18,0.0275} "Thickness of wall layers",
          rho={382,93,1018.2} "Density of wall layers",
          lambda={0.052,0.78,0.346} "Thermal conductivity of wall layers",
          c={1006,1593,1000} "Specific heat capacity of wall layers",
          eps=0.95 "Emissivity of inner wall surface");

      /*   n(min=1) = 5 "Number of wall layers",
    d={0.02,0.0125,0.18,0.0125,0.015} "Thickness of wall layers",
    rho={120,800,93,800,1200} "Density of wall layers",
    lambda={0.035,0.25,0.78,0.25,0.51} "Thermal conductivity of wall layers",
    c={1030,1000,1593,1000,1000} "Specific heat capacity of wall layers",
    eps=0.95 "Emissivity of inner wall surface");
    */
        annotation (Documentation(revisions="<html>
<p><ul>
<li><i>September 5, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
<li><i>Juni 1, 2011</i> by Ana Constantin:<br/>implemented</li>
</ul></p>
</html>", info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Wall definition according to EnEV 2002. For detailed wall type see above. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars5.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>port_a</code>(outside), the last element represents the layer connected to <code>port_b</code>(surface facing the room). </p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a></p>
<p>Norm: </p>
<ul>
<li>Energieeinsparverordnung 2002. 2002</li>
</ul>
</html>"));
      end IWneighbour_EnEV2002_L_half;
    end IW;

    package Floor
          extends Modelica.Icons.Package;

    record FLground_EnEV2002_SML
        "Floor towards ground after EnEV 2002, for building of type S (schwer), M (mittel) and L (leicht)"
        extends WallBaseDataDefinition(
          n(min=1) = 4 "Number of wall layers",
          d={0.4,0.25,0.04,0.06} "Thickness of wall layers",
          rho={100,2300,120,2000} "Density of wall layers",
          lambda={0.055,2.3,0.04,1.4} "Thermal conductivity of wall layers",
          c={1000,1000,1030,1000} "Specific heat capacity of wall layers",
          eps=0.95 "Emissivity of inner wall surface");
        annotation (Documentation(revisions="<html>
<p><ul>
<li><i>September 5, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
<li><i>Juni 1, 2011</i> by Ana Constantin:<br/>implemented</li>
</ul></p>
</html>",
    info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Wall definition according to EnEV 2002. For detailed wall type see above. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars5.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>port_a</code>(outside), the last element represents the layer connected to <code>port_b</code>(surface facing the room). </p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a></p>
<p>Norm: </p>
<ul>
<li>Energieeinsparverordnung 2002. 2002</li>
</ul>
</html>"));
    end FLground_EnEV2002_SML;

    record FLpartition_EnEV2002_SM_upHalf
        "Floor partition after EnEV 2002, for building of type S (schwer) and M (mittel), upper half"
        extends WallBaseDataDefinition(
          n(min=1) = 2 "Number of wall layers",
          d={0.02,0.06} "Thickness of wall layers",
          rho={120,2000} "Density of wall layers",
          lambda={0.045,1.4} "Thermal conductivity of wall layers",
          c={1030,1000} "Specific heat capacity of wall layers",
          eps=0.95 "Emissivity of inner wall surface");
        annotation (Documentation(revisions="<html>
<p><ul>
<li><i>September 5, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
<li><i>Juni 1, 2011</i> by Ana Constantin:<br/>implemented</li>
</ul></p>
</html>",
    info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Wall definition according to EnEV 2002. For detailed wall type see above. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars5.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>port_a</code>(outside), the last element represents the layer connected to <code>port_b</code>(surface facing the room). </p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a></p>
<p>Norm: </p>
<ul>
<li>Energieeinsparverordnung 2002. 2002</li>
</ul>
</html>"));
    end FLpartition_EnEV2002_SM_upHalf;

    record FLpartition_EnEV2002_L_upHalf
        "Floor partition after EnEV 2002, for building of typeL (leicht), upper half"
        extends WallBaseDataDefinition(
          n(min=1) = 2 "Number of wall layers",
          d={0.02,0.06} "Thickness of wall layers",
          rho={120,2000} "Density of wall layers",
          lambda={0.045,1.4} "Thermal conductivity of wall layers",
          c={1030,1000} "Specific heat capacity of wall layers",
          eps=0.95 "Emissivity of inner wall surface");
        annotation (Documentation(revisions="<html>
<p><ul>
<li><i>September 5, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
<li><i>Juni 1, 2011</i> by Ana Constantin:<br/>implemented</li>
</ul></p>
</html>",
    info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Wall definition according to EnEV 2002. For detailed wall type see above. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars5.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>port_a</code>(outside), the last element represents the layer connected to <code>port_b</code>(surface facing the room). </p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a></p>
<p>Norm: </p>
<ul>
<li>Energieeinsparverordnung 2002. 2002</li>
</ul>
</html>"));
    end FLpartition_EnEV2002_L_upHalf;

    record FLcellar_EnEV2002_SML_upHalf
        "Floor towards cellar after EnEV 2002, for building of type S (schwer), M (mittel) and L (leicht), upper half."
        extends WallBaseDataDefinition(
          n(min=1) = 2 "Number of wall layers",
          d={0.02,0.06} "Thickness of wall layers",
          rho={120,2000} "Density of wall layers",
          lambda={0.035,1.4} "Thermal conductivity of wall layers",
          c={1030,1000} "Specific heat capacity of wall layers",
          eps=0.95 "Emissivity of inner wall surface");
        annotation (Documentation(revisions="<html>
<p><ul>
<li><i>September 5, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
<li><i>Juni 1, 2011</i> by Ana Constantin:<br/>implemented</li>
</ul></p>
</html>",
    info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Wall definition according to EnEV 2002. For detailed wall type see above. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars5.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>port_a</code>(outside), the last element represents the layer connected to <code>port_b</code>(surface facing the room). </p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a></p>
<p>Norm: </p>
<ul>
<li>Energieeinsparverordnung 2002. 2002</li>
</ul>
</html>"));
    end FLcellar_EnEV2002_SML_upHalf;
    end Floor;

    package Ceiling
          extends Modelica.Icons.Package;

    record CEpartition_EnEV2002_SM_loHalf
        "Ceiling partition after EnEV 2002, for building of type S (schwer) and M (mittel), lower half"
        extends WallBaseDataDefinition(
          n(min=1) = 3 "Number of wall layers",
          d={0.02,0.16,0.015} "Thickness of wall layers",
          rho={120,2300,1200} "Density of wall layers",
          lambda={0.045,2.3,0.51} "Thermal conductivity of wall layers",
          c={1030,1000,1000} "Specific heat capacity of wall layers",
          eps=0.95 "Emissivity of inner wall surface");
        annotation (Documentation(revisions="<html>
<p><ul>
<li><i>September 5, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
<li><i>Juni 1, 2011</i> by Ana Constantin:<br/>implemented</li>
</ul></p>
</html>",
    info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Wall definition according to EnEV 2002. For detailed wall type see above. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars5.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>port_a</code>(outside), the last element represents the layer connected to <code>port_b</code>(surface facing the room). </p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a></p>
<p>Norm: </p>
<ul>
<li>Energieeinsparverordnung 2002. 2002</li>
</ul>
</html>"));
    end CEpartition_EnEV2002_SM_loHalf;

    record CEpartition_EnEV2002_L_loHalf
        "Ceiling partition after EnEV 2002, for building of type L (leicht), lower half"
      // New Walls for Dymola 2012, the same number of layers as other mass clases
        extends WallBaseDataDefinition(
          n(min=1) = 3 "Number of wall layers",
          d={0.04,0.16,0.0275} "Thickness of wall layers",
          rho={210,93,1018.2} "Density of wall layers",
          lambda={0.062,0.71,0.346} "Thermal conductivity of wall layers",
          c={1509,1593,1000} "Specific heat capacity of wall layers",
          eps=0.95 "Emissivity of inner wall surface");

    /*       n(min=1) = 5 "Number of wall layers",
      d={0.02,0.02,0.16,0.0125,0.015} "Thickness of wall layers",
      rho={120,300,93,800,1200} "Density of wall layers",
      lambda={0.045,0.1,0.71,0.25,0.51} "Thermal conductivity of wall layers",
      c={1030,1700,1593,1000,1000} "Specific heat capacity of wall layers",
      eps=0.95 "Emissivity of inner wall surface");
*/

        annotation (Documentation(revisions="<html>
<p><ul>
<li><i>September 5, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
<li><i>Juni 1, 2011</i> by Ana Constantin:<br/>implemented</li>
</ul></p>
</html>",
    info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Wall definition according to EnEV 2002. For detailed wall type see above. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars5.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>port_a</code>(outside), the last element represents the layer connected to <code>port_b</code>(surface facing the room). </p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a></p>
<p>Norm: </p>
<ul>
<li>Energieeinsparverordnung 2002. 2002</li>
</ul>
</html>"));
    end CEpartition_EnEV2002_L_loHalf;

    record CEattic_EnEV2002_SML_loHalf
        "Ceiling towards attic after EnEV 2002, for building of type S (schwer), M (mittel) and L (leicht), lower half"
        extends WallBaseDataDefinition(
          n(min=1) = 3 "Number of wall layers",
          d={0.08,0.0125,0.015} "Thickness of wall layers",
          rho={160,800,1200} "Density of wall layers",
          lambda={0.058,0.25,0.51} "Thermal conductivity of wall layers",
          c={1358,1000,1000} "Specific heat capacity of wall layers",
          eps=0.95 "Emissivity of inner wall surface");
        annotation (Documentation(revisions="<html>
<p><ul>
<li><i>September 5, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
<li><i>Juni 1, 2011</i> by Ana Constantin:<br/>implemented</li>
</ul></p>
</html>",
    info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Wall definition according to EnEV 2002. For detailed wall type see above. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars5.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>port_a</code>(outside), the last element represents the layer connected to <code>port_b</code>(surface facing the room). </p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a></p>
<p>Norm: </p>
<ul>
<li>Energieeinsparverordnung 2002. 2002</li>
</ul>
</html>"));
    end CEattic_EnEV2002_SML_loHalf;

    record CEcellar_EnEV2002_SML_loHalf
        "Ceiling cellar after EnEV 2002, for building of type S (schwer), M (mittel) and L (leicht), lower half"
        extends WallBaseDataDefinition(
          n(min=1) = 3 "Number of wall layers",
          d={0.02,0.16,0.02} "Thickness of wall layers",
          rho={120,2300,120} "Density of wall layers",
          lambda={0.035,2.3,0.035} "Thermal conductivity of wall layers",
          c={1030,1000,1030} "Specific heat capacity of wall layers",
          eps=0.95 "Emissivity of inner wall surface");
        annotation (Documentation(revisions="<html>
<p><ul>
<li><i>September 5, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
<li><i>Juni 1, 2011</i> by Ana Constantin:<br/>implemented</li>
</ul></p>
</html>",
    info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Wall definition according to EnEV 2002. For detailed wall type see above. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars5.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>port_a</code>(outside), the last element represents the layer connected to <code>port_b</code>(surface facing the room). </p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a></p>
<p>Norm: </p>
<ul>
<li>Energieeinsparverordnung 2002. 2002</li>
</ul>
</html>"));
    end CEcellar_EnEV2002_SML_loHalf;

    record ROsaddleAttic_EnEV2002_SML
        "Saddle roof in attic after EnEV 2002, for building of type S (schwer), M (mittel) and L (leicht)"
        extends WallBaseDataDefinition(
          n(min=1) = 1 "Number of wall layers",
          d={0.18} "Thickness of wall layers",
          rho={181} "Density of wall layers",
          lambda={0.054} "Thermal conductivity of wall layers",
          c={1320} "Specific heat capacity of wall layers",
          eps=0.95 "Emissivity of inner wall surface");
        annotation (Documentation(revisions="<html>
<p><ul>
<li><i>September 5, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
<li><i>Juni 1, 2011</i> by Ana Constantin:<br/>implemented</li>
</ul></p>
</html>",
    info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Wall definition according to EnEV 2002. For detailed wall type see above. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars5.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>port_a</code>(outside), the last element represents the layer connected to <code>port_b</code>(surface facing the room). </p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a></p>
<p>Norm: </p>
<ul>
<li>Energieeinsparverordnung 2002. 2002</li>
</ul>
</html>"));
    end ROsaddleAttic_EnEV2002_SML;

    record ROsaddleRoom_EnEV2002_SML
        "Saddle roof in room after EnEV 2002, for building of type S (schwer), M (mittel) and L (leicht)"
        extends WallBaseDataDefinition(
          n(min=1) = 3 "Number of wall layers",
          d={0.18,0.0125,0.015} "Thickness of wall layers",
          rho={181,800,1200} "Density of wall layers",
          lambda={0.054,0.25,0.51} "Thermal conductivity of wall layers",
          c={1320,1000,1000} "Specific heat capacity of wall layers",
          eps=0.95 "Emissivity of inner wall surface");
        annotation (Documentation(revisions="<html>
<p><ul>
<li><i>September 5, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
<li><i>Juni 1, 2011</i> by Ana Constantin:<br/>implemented</li>
</ul></p>
</html>",
    info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Wall definition according to EnEV 2002. For detailed wall type see above. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars5.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>port_a</code>(outside), the last element represents the layer connected to <code>port_b</code>(surface facing the room). </p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a></p>
<p>Norm: </p>
<ul>
<li>Energieeinsparverordnung 2002. 2002</li>
</ul>
</html>"));
    end ROsaddleRoom_EnEV2002_SML;
    end Ceiling;
  end EnEV2002;

  package EnEV2009
        extends Modelica.Icons.Package;

    package OW
          extends Modelica.Icons.Package;

      record OW_EnEV2009_S
        "outer wall after EnEV 2009, for building of type S (schwer)"
        extends WallBaseDataDefinition(
          n(min=1) = 4 "Number of wall layers",
          d={0.05,0.1,0.24,0.015} "Thickness of wall layers",
          rho={1800,120,1000,1200} "Density of wall layers",
          lambda={1,0.035,0.5,0.51} "Thermal conductivity of wall layers",
          c={1000,1030,1000,1000} "Specific heat capacity of wall layers",
          eps=0.95 "Emissivity of inner wall surface");
        annotation (Documentation(revisions="<html>
<p><ul>
<li><i>September 5, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
<li><i>Juni 1, 2011</i> by Ana Constantin:<br/>implemented</li>
</ul></p>
</html>", info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Wall definition according to EnEV 2009. For detailed wall type see above. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars5.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>port_a</code>(outside), the last element represents the layer connected to <code>port_b</code>(surface facing the room). </p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a></p>
<p>Norm: </p>
<ul>
<li>Bundesregierung (Veranst.): Verordnung &uuml;ber energiesparenden W&auml;rmeschutz und energiesparende Anlagentechnik bei Geb&auml;uden. Berlin, 2009</li>
</ul>
</html>"));
      end OW_EnEV2009_S;

      record OW_EnEV2009_M
        "outer wall after EnEV 2009, for building of type M (mittel)"
        extends WallBaseDataDefinition(
          n(min=1) = 4 "Number of wall layers",
          d={0.05,0.6,0.175,0.015} "Thickness of wall layers",
          rho={1800,120,350,1200} "Density of wall layers",
          lambda={1,0.035,0.11,0.51} "Thermal conductivity of wall layers",
          c={1000,1030,1000,1000} "Specific heat capacity of wall layers",
          eps=0.95 "Emissivity of inner wall surface");

        annotation (Documentation(revisions="<html>
<p><ul>
<li><i>September 5, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
<li><i>Juni 1, 2011</i> by Ana Constantin:<br/>implemented</li>
</ul></p>
</html>", info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Wall definition according to EnEV 2009. For detailed wall type see above. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars5.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>port_a</code>(outside), the last element represents the layer connected to <code>port_b</code>(surface facing the room). </p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a></p>
<p>Norm: </p>
<ul>
<li>Bundesregierung (Veranst.): Verordnung &uuml;ber energiesparenden W&auml;rmeschutz und energiesparende Anlagentechnik bei Geb&auml;uden. Berlin, 2009 </li>
</ul>
</html>"));
      end OW_EnEV2009_M;

      record OW_EnEV2009_L
        "outer wall after EnEV 2009, for building of type L (leicht)"
        extends WallBaseDataDefinition(
          n(min=1) = 4 "Number of wall layers",
          d={0.03,0.02,0.18,0.0275} "Thickness of wall layers",
          rho={1800,300,172,1018.2} "Density of wall layers",
          lambda={1,0.1,0.056,0.346} "Thermal conductivity of wall layers",
          c={1000,1700,1337,1000} "Specific heat capacity of wall layers",
          eps=0.95 "Emissivity of inner wall surface");

          // New Walls for Dymola 2012, the same number of layers as other mass clases

         // n(min=1) = 5 "Number of wall layers",
         // d={0.03,0.02,0.18,0.0125,0.015} "Thickness of wall layers",
         // rho={1800,300,172,800,1200} "Density of wall layers",
         // lambda={1,0.1,0.056,0.25,0.51} "Thermal conductivity of wall layers",
         // c={1000,1700,1337,1000,1000} "Specific heat capacity of wall layers",

        annotation (Documentation(revisions="<html>
<p><ul>
<li><i>September 5, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
<li><i>Juni 1, 2011</i> by Ana Constantin:<br/>implemented</li>
</ul></p>
</html>", info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Wall definition according to EnEV 2009. For detailed wall type see above. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars5.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>port_a</code>(outside), the last element represents the layer connected to <code>port_b</code>(surface facing the room). </p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a></p>
<p>Norm: </p>
<ul>
<li>Bundesregierung (Veranst.): Verordnung &uuml;ber energiesparenden W&auml;rmeschutz und energiesparende Anlagentechnik bei Geb&auml;uden. Berlin, 2009 </li>
</ul>
</html>"));
      end OW_EnEV2009_L;
    end OW;

    package IW
          extends Modelica.Icons.Package;

      record IWsimple_EnEV2009_S_half
        "Inner wall simple after EnEV 2009, for building of type S (schwer), only half"
        extends WallBaseDataDefinition(
          n(min=1) = 2 "Number of wall layers",
          d={0.0575,0.015} "Thickness of wall layers",
          rho={1000,1200} "Density of wall layers",
          lambda={0.5,0.51} "Thermal conductivity of wall layers",
          c={1000,1000} "Specific heat capacity of wall layers",
          eps=0.95 "Emissivity of inner wall surface");
        annotation (Documentation(revisions="<html>
<p><ul>
<li><i>September 5, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
<li><i>Juni 1, 2011</i> by Ana Constantin:<br/>implemented</li>
</ul></p>
</html>", info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Wall definition according to EnEV 2009. For detailed wall type see above. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars5.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>port_a</code>(outside), the last element represents the layer connected to <code>port_b</code>(surface facing the room). </p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a></p>
<p>Norm: </p>
<ul>
<li>Bundesregierung (Veranst.): Verordnung &uuml;ber energiesparenden W&auml;rmeschutz und energiesparende Anlagentechnik bei Geb&auml;uden. Berlin, 2009 </li>
</ul>
</html>"));
      end IWsimple_EnEV2009_S_half;

      record IWload_EnEV2009_S_half
        "Inner wall load-bearing after EnEV 2009, for building of type S (schwer), only half"
        extends WallBaseDataDefinition(
          n(min=1) = 2 "Number of wall layers",
          d={0.0875,0.015} "Thickness of wall layers",
          rho={1000,1200} "Density of wall layers",
          lambda={0.5,0.51} "Thermal conductivity of wall layers",
          c={1000,1000} "Specific heat capacity of wall layers",
          eps=0.95 "Emissivity of inner wall surface");
        annotation (Documentation(revisions="<html>
<p><ul>
<li><i>September 5, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
<li><i>Juni 1, 2011</i> by Ana Constantin:<br/>implemented</li>
</ul></p>
</html>", info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Wall definition according to EnEV 2009. For detailed wall type see above. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars5.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>port_a</code>(outside), the last element represents the layer connected to <code>port_b</code>(surface facing the room). </p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a></p>
<p>Norm: </p>
<ul>
<li>Bundesregierung (Veranst.): Verordnung &uuml;ber energiesparenden W&auml;rmeschutz und energiesparende Anlagentechnik bei Geb&auml;uden. Berlin, 2009 </li>
</ul>
</html>"));
      end IWload_EnEV2009_S_half;

      record IWneighbour_EnEV2009_S_half
        "Inner wall towards neighbour after EnEV 2009, for building of type S (schwer), only half"
        extends WallBaseDataDefinition(
          n(min=1) = 3 "Number of wall layers",
          d={0.02,0.175,0.015} "Thickness of wall layers",
          rho={120,1000,1200} "Density of wall layers",
          lambda={0.035,0.5,0.51} "Thermal conductivity of wall layers",
          c={1030,1000,1000} "Specific heat capacity of wall layers",
          eps=0.95 "Emissivity of inner wall surface");
        annotation (Documentation(revisions="<html>
<p><ul>
<li><i>September 5, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
<li><i>Juni 1, 2011</i> by Ana Constantin:<br/>implemented</li>
</ul></p>
</html>", info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Wall definition according to EnEV 2009. For detailed wall type see above. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars5.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>port_a</code>(outside), the last element represents the layer connected to <code>port_b</code>(surface facing the room). </p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a></p>
<p>Norm: </p>
<ul>
<li>Bundesregierung (Veranst.): Verordnung &uuml;ber energiesparenden W&auml;rmeschutz und energiesparende Anlagentechnik bei Geb&auml;uden. Berlin, 2009 </li>
</ul>
</html>"));
      end IWneighbour_EnEV2009_S_half;

      record IWsimple_EnEV2009_M_half
        "Inner wall simple after EnEV, for building of type M (mittel), only half"
        extends WallBaseDataDefinition(
          n(min=1) = 2 "Number of wall layers",
          d={0.0575,0.015} "Thickness of wall layers",
          rho={1000,1200} "Density of wall layers",
          lambda={0.315,0.51} "Thermal conductivity of wall layers",
          c={1000,1000} "Specific heat capacity of wall layers",
          eps=0.95 "Emissivity of inner wall surface");
        annotation (Documentation(revisions="<html>
<p><ul>
<li><i>September 5, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
<li><i>Juni 1, 2011</i> by Ana Constantin:<br/>implemented</li>
</ul></p>
</html>", info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Wall definition according to EnEV 2009. For detailed wall type see above. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars5.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>port_a</code>(outside), the last element represents the layer connected to <code>port_b</code>(surface facing the room). </p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a></p>
<p>Norm: </p>
<ul>
<li>Bundesregierung (Veranst.): Verordnung &uuml;ber energiesparenden W&auml;rmeschutz und energiesparende Anlagentechnik bei Geb&auml;uden. Berlin, 2009 </li>
</ul>
</html>"));
      end IWsimple_EnEV2009_M_half;

      record IWload_EnEV2009_M_half
        "Inner wall load-bearing after EnEV 2009, for building of type M (schwer), only half"
        extends WallBaseDataDefinition(
          n(min=1) = 2 "Number of wall layers",
          d={0.0875,0.015} "Thickness of wall layers",
          rho={1000,1200} "Density of wall layers",
          lambda={0.315,0.51} "Thermal conductivity of wall layers",
          c={1000,1000} "Specific heat capacity of wall layers",
          eps=0.95 "Emissivity of inner wall surface");
        annotation (Documentation(revisions="<html>
<p><ul>
<li><i>September 5, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
<li><i>Juni 1, 2011</i> by Ana Constantin:<br/>implemented</li>
</ul></p>
</html>", info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Wall definition according to EnEV 2009. For detailed wall type see above. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars5.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>port_a</code>(outside), the last element represents the layer connected to <code>port_b</code>(surface facing the room). </p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a></p>
<p>Norm: </p>
<ul>
<li>Bundesregierung (Veranst.): Verordnung &uuml;ber energiesparenden W&auml;rmeschutz und energiesparende Anlagentechnik bei Geb&auml;uden. Berlin, 2009 </li>
</ul>
</html>"));
      end IWload_EnEV2009_M_half;

      record IWneighbour_EnEV2009_M_half
        "Inner wall towards neighbour after EnEV 2009, for building of type S (mitel), only half"
        extends WallBaseDataDefinition(
          n(min=1) = 3 "Number of wall layers",
          d={0.02,0.175,0.015} "Thickness of wall layers",
          rho={120,1000,1200} "Density of wall layers",
          lambda={0.035,0.315,0.51} "Thermal conductivity of wall layers",
          c={1030,1000,1000} "Specific heat capacity of wall layers",
          eps=0.95 "Emissivity of inner wall surface");
        annotation (Documentation(revisions="<html>
<p><ul>
<li><i>September 5, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
<li><i>Juni 1, 2011</i> by Ana Constantin:<br/>implemented</li>
</ul></p>
</html>", info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Wall definition according to EnEV 2009. For detailed wall type see above. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars5.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>port_a</code>(outside), the last element represents the layer connected to <code>port_b</code>(surface facing the room). </p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a></p>
<p>Norm: </p>
<ul>
<li>Bundesregierung (Veranst.): Verordnung &uuml;ber energiesparenden W&auml;rmeschutz und energiesparende Anlagentechnik bei Geb&auml;uden. Berlin, 2009 </li>
</ul>
</html>"));
      end IWneighbour_EnEV2009_M_half;

      record IWsimple_EnEV2009_L_half
        "Inner wall simple after EnEV, for building of type L (leicht), only half"
        // New Walls for Dymola 2012, the same number of layers as other mass clases
        extends WallBaseDataDefinition(
          n(min=1) = 2 "Number of wall layers",
          d={0.05,0.0275} "Thickness of wall layers",
          rho={93,1018.2} "Density of wall layers",
          lambda={0.44,0.346} "Thermal conductivity of wall layers",
          c={1593,1000} "Specific heat capacity of wall layers",
          eps=0.95 "Emissivity of inner wall surface");

         // n(min=1) = 3 "Number of wall layers",
         // d={0.05,0.0125,0.015} "Thickness of wall layers",
         // rho={93,800,1200} "Density of wall layers",
         // lambda={0.44,0.25,0.51} "Thermal conductivity of wall layers",
         // c={1593,1000,1000} "Specific heat capacity of wall layers",
         // eps=0.95 "Emissivity of inner wall surface"

        annotation (Documentation(revisions="<html>
<p><ul>
<li><i>September 5, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
<li><i>Juni 1, 2011</i> by Ana Constantin:<br/>implemented</li>
</ul></p>
</html>", info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Wall definition according to EnEV 2009. For detailed wall type see above. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars5.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>port_a</code>(outside), the last element represents the layer connected to <code>port_b</code>(surface facing the room). </p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a></p>
<p>Norm: </p>
<ul>
<li>Bundesregierung (Veranst.): Verordnung &uuml;ber energiesparenden W&auml;rmeschutz und energiesparende Anlagentechnik bei Geb&auml;uden. Berlin, 2009 </li>
</ul>
</html>"));
      end IWsimple_EnEV2009_L_half;

      record IWload_EnEV2009_L_half
        "Inner wall load-bearing after EnEV 2009, for building of type L (leicht), only half"
        // New Walls for Dymola 2012, the same number of layers as other mass clases
        extends WallBaseDataDefinition(
          n(min=1) = 2 "Number of wall layers",
          d={0.09,0.0275} "Thickness of wall layers",
          rho={93,1018.2} "Density of wall layers",
          lambda={0.78,0.346} "Thermal conductivity of wall layers",
          c={1593,1000} "Specific heat capacity of wall layers",
          eps=0.95 "Emissivity of inner wall surface");
         // n(min=1) = 3 "Number of wall layers",
         // d={0.09,0.0125,0.015} "Thickness of wall layers",
         // rho={93,800,1200} "Density of wall layers",
         // lambda={0.78,0.25,0.51} "Thermal conductivity of wall layers",
         // c={1593,1000,1000} "Specific heat capacity of wall layers",
         // eps=0.95 "Emissivity of inner wall surface"

        annotation (Documentation(revisions="<html>
<p><ul>
<li><i>September 5, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
<li><i>Juni 1, 2011</i> by Ana Constantin:<br/>implemented</li>
</ul></p>
</html>", info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Wall definition according to EnEV 2009. For detailed wall type see above. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars5.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>port_a</code>(outside), the last element represents the layer connected to <code>port_b</code>(surface facing the room). </p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a></p>
<p>Norm: </p>
<ul>
<li>Bundesregierung (Veranst.): Verordnung &uuml;ber energiesparenden W&auml;rmeschutz und energiesparende Anlagentechnik bei Geb&auml;uden. Berlin, 2009 </li>
</ul>
</html>"));
      end IWload_EnEV2009_L_half;

      record IWneighbour_EnEV2009_L_half
        "Inner wall towards neighbour after EnEV 2009, for building of type L (leicht), only half"
       // New Walls for Dymola 2012, the same number of layers as other mass clases
        extends WallBaseDataDefinition(
          n(min=1) = 3 "Number of wall layers",
          d={0.0325,0.18,0.0275} "Thickness of wall layers",
          rho={382,93,1018.2} "Density of wall layers",
          lambda={0.052,0.78,0.346} "Thermal conductivity of wall layers",
          c={1006,1593,1000} "Specific heat capacity of wall layers",
          eps=0.95 "Emissivity of inner wall surface");

         // n(min=1) = 5 "Number of wall layers",
         // d={0.02,0.0125,0.18,0.0125,0.015} "Thickness of wall layers",
         // rho={120,800,93,800,1200} "Density of wall layers",
         // lambda={0.035,0.25,0.78,0.25,0.51} "Thermal conductivity of wall layers",
         // c={1593,1000,1099,1000,1000} "Specific heat capacity of wall layers",
         // eps=0.95 "Emissivity of inner wall surface"

        annotation (Documentation(revisions="<html>
<p><ul>
<li><i>September 5, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
<li><i>Juni 1, 2011</i> by Ana Constantin:<br/>implemented</li>
</ul></p>
</html>", info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Wall definition according to EnEV 2009. For detailed wall type see above. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars5.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>port_a</code>(outside), the last element represents the layer connected to <code>port_b</code>(surface facing the room). </p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a></p>
<p>Norm: </p>
<ul>
<li>Bundesregierung (Veranst.): Verordnung &uuml;ber energiesparenden W&auml;rmeschutz und energiesparende Anlagentechnik bei Geb&auml;uden. Berlin, 2009 </li>
</ul>
</html>"));
      end IWneighbour_EnEV2009_L_half;
    end IW;

    package Floor
          extends Modelica.Icons.Package;

    record FLground_EnEV2009_SML
        "Floor towards ground after EnEV 2009, for building of type S (schwer), M (mittel) and L (leicht)"
        extends WallBaseDataDefinition(
          n(min=1) = 4 "Number of wall layers",
          d={0.06,0.25,0.04,0.06} "Thickness of wall layers",
          rho={140,2300,120,2000} "Density of wall layers",
          lambda={0.040,2.3,0.035,1.4} "Thermal conductivity of wall layers",
          c={1000,1000,1030,1000} "Specific heat capacity of wall layers",
          eps=0.95 "Emissivity of inner wall surface");
        annotation (Documentation(revisions="<html>
<p><ul>
<li><i>September 5, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
<li><i>Juni 1, 2011</i> by Ana Constantin:<br/>implemented</li>
</ul></p>
</html>",
    info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Wall definition according to EnEV 2009. For detailed wall type see above. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars5.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>port_a</code>(outside), the last element represents the layer connected to <code>port_b</code>(surface facing the room). </p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a></p>
<p>Norm: </p>
<ul>
<li>Bundesregierung (Veranst.): Verordnung &uuml;ber energiesparenden W&auml;rmeschutz und energiesparende Anlagentechnik bei Geb&auml;uden. Berlin, 2009 </li>
</ul>
</html>"));
    end FLground_EnEV2009_SML;

    record FLpartition_EnEV2009_SM_upHalf
        "Floor partition after EnEV 2009, for building of type S (schwer) and M (mittel), upper half"
        extends WallBaseDataDefinition(
          n(min=1) = 2 "Number of wall layers",
          d={0.02,0.06} "Thickness of wall layers",
          rho={120,2000} "Density of wall layers",
          lambda={0.045,1.4} "Thermal conductivity of wall layers",
          c={1030,1000} "Specific heat capacity of wall layers",
          eps=0.95 "Emissivity of inner wall surface");
        annotation (Documentation(revisions="<html>
<p><ul>
<li><i>September 5, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
<li><i>Juni 1, 2011</i> by Ana Constantin:<br/>implemented</li>
</ul></p>
</html>",
    info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Wall definition according to EnEV 2009. For detailed wall type see above. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars5.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>port_a</code>(outside), the last element represents the layer connected to <code>port_b</code>(surface facing the room). </p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a></p>
<p>Norm: </p>
<ul>
<li>Bundesregierung (Veranst.): Verordnung &uuml;ber energiesparenden W&auml;rmeschutz und energiesparende Anlagentechnik bei Geb&auml;uden. Berlin, 2009 </li>
</ul>
</html>"));
    end FLpartition_EnEV2009_SM_upHalf;

    record FLpartition_EnEV2009_L_upHalf
        "Floor partition after EnEV 2009, for building of typeL (leicht), upper half"
        extends WallBaseDataDefinition(
          n(min=1) = 2 "Number of wall layers",
          d={0.02,0.06} "Thickness of wall layers",
          rho={120,2000} "Density of wall layers",
          lambda={0.045,1.4} "Thermal conductivity of wall layers",
          c={1030,1000} "Specific heat capacity of wall layers",
          eps=0.95 "Emissivity of inner wall surface");
        annotation (Documentation(revisions="<html>
<p><ul>
<li><i>September 5, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
<li><i>Juni 1, 2011</i> by Ana Constantin:<br/>implemented</li>
</ul></p>
</html>",
    info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Wall definition according to EnEV 2009. For detailed wall type see above. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars5.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>port_a</code>(outside), the last element represents the layer connected to <code>port_b</code>(surface facing the room). </p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a></p>
<p>Norm: </p>
<ul>
<li>Bundesregierung (Veranst.): Verordnung &uuml;ber energiesparenden W&auml;rmeschutz und energiesparende Anlagentechnik bei Geb&auml;uden. Berlin, 2009 </li>
</ul>
</html>"));
    end FLpartition_EnEV2009_L_upHalf;

    record FLcellar_EnEV2009_SML_upHalf
        "Floor towards cellar after EnEV 2009, for building of type S (schwer), M (mittel) and L (leicht), upper half."
        extends WallBaseDataDefinition(
          n(min=1) = 2 "Number of wall layers",
          d={0.02,0.06} "Thickness of wall layers",
          rho={120,2000} "Density of wall layers",
          lambda={0.045,1.4} "Thermal conductivity of wall layers",
          c={1030,1000} "Specific heat capacity of wall layers",
          eps=0.95 "Emissivity of inner wall surface");
        annotation (Documentation(revisions="<html>
<p><ul>
<li><i>September 5, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
<li><i>Juni 1, 2011</i> by Ana Constantin:<br/>implemented</li>
</ul></p>
</html>",
    info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Wall definition according to EnEV 2009. For detailed wall type see above. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars5.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>port_a</code>(outside), the last element represents the layer connected to <code>port_b</code>(surface facing the room). </p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a></p>
<p>Norm: </p>
<ul>
<li>Bundesregierung (Veranst.): Verordnung &uuml;ber energiesparenden W&auml;rmeschutz und energiesparende Anlagentechnik bei Geb&auml;uden. Berlin, 2009 </li>
</ul>
</html>"));
    end FLcellar_EnEV2009_SML_upHalf;
    end Floor;

    package Ceiling
          extends Modelica.Icons.Package;

    record CEpartition_EnEV2009_SM_loHalf
        "Ceiling partition after EnEV 2009, for building of type S (schwer) and M (mittel), lower half"
        extends WallBaseDataDefinition(
          n(min=1) = 3 "Number of wall layers",
          d={0.02,0.16,0.015} "Thickness of wall layers",
          rho={120,2300,1200} "Density of wall layers",
          lambda={0.045,2.3,0.51} "Thermal conductivity of wall layers",
          c={1030,1000,1000} "Specific heat capacity of wall layers",
          eps=0.95 "Emissivity of inner wall surface");
        annotation (Documentation(revisions="<html>
<p><ul>
<li><i>September 5, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
<li><i>Juni 1, 2011</i> by Ana Constantin:<br/>implemented</li>
</ul></p>
</html>",
    info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Wall definition according to EnEV 2009. For detailed wall type see above. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars5.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>port_a</code>(outside), the last element represents the layer connected to <code>port_b</code>(surface facing the room). </p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a></p>
<p>Norm: </p>
<ul>
<li>Bundesregierung (Veranst.): Verordnung &uuml;ber energiesparenden W&auml;rmeschutz und energiesparende Anlagentechnik bei Geb&auml;uden. Berlin, 2009 </li>
</ul>
</html>"));
    end CEpartition_EnEV2009_SM_loHalf;

    record CEpartition_EnEV2009_L_loHalf
        "Ceiling partition after EnEV 2009, for building of type L (leicht), lower half"
      // New Walls for Dymola 2012, the same number of layers as other mass clases
        extends WallBaseDataDefinition(
          n(min=1) = 3 "Number of wall layers",
          d={0.04,0.16,0.0275} "Thickness of wall layers",
          rho={210,93,1018.2} "Density of wall layers",
          lambda={0.062,0.71,0.346} "Thermal conductivity of wall layers",
          c={1509,1593,1000} "Specific heat capacity of wall layers",
          eps=0.95 "Emissivity of inner wall surface");

    //       n(min=1) = 5 "Number of wall layers",
    //      d={0.02,0.02,0.16,0.0125,0.015} "Thickness of wall layers",
    //      rho={120,300,93,800,1200} "Density of wall layers",
    //      lambda={0.045,0.1,0.71,0.25,0.51} "Thermal conductivity of wall layers",
    //      c={1030,1700,1593,1000,1000} "Specific heat capacity of wall layers",
    //      eps=0.95 "Emissivity of inner wall surface");

        annotation (Documentation(revisions="<html>
<p><ul>
<li><i>September 5, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
<li><i>Juni 1, 2011</i> by Ana Constantin:<br/>implemented</li>
</ul></p>
</html>",
    info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Wall definition according to EnEV 2009. For detailed wall type see above. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars5.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>port_a</code>(outside), the last element represents the layer connected to <code>port_b</code>(surface facing the room). </p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a></p>
<p>Norm: </p>
<ul>
<li>Bundesregierung (Veranst.): Verordnung &uuml;ber energiesparenden W&auml;rmeschutz und energiesparende Anlagentechnik bei Geb&auml;uden. Berlin, 2009 </li>
</ul>
</html>"));
    end CEpartition_EnEV2009_L_loHalf;

    record CEattic_EnEV2009_SML_loHalf
        "Ceiling towards attic after EnEV 2009, for building of type S (schwer), M (mittel) and L (leicht), lower half"
        extends WallBaseDataDefinition(
          n(min=1) = 3 "Number of wall layers",
          d={0.1,0.0125,0.015} "Thickness of wall layers",
          rho={194,800,1200} "Density of wall layers",
          lambda={0.045,0.25,0.51} "Thermal conductivity of wall layers",
          c={1301,1000,1000} "Specific heat capacity of wall layers",
          eps=0.95 "Emissivity of inner wall surface");
        annotation (Documentation(revisions="<html>
<p><ul>
<li><i>September 5, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
<li><i>Juni 1, 2011</i> by Ana Constantin:<br/>implemented</li>
</ul></p>
</html>",
    info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Wall definition according to EnEV 2009. For detailed wall type see above. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars5.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>port_a</code>(outside), the last element represents the layer connected to <code>port_b</code>(surface facing the room). </p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a></p>
<p>Norm: </p>
<ul>
<li>Bundesregierung (Veranst.): Verordnung &uuml;ber energiesparenden W&auml;rmeschutz und energiesparende Anlagentechnik bei Geb&auml;uden. Berlin, 2009 </li>
</ul>
</html>"));
    end CEattic_EnEV2009_SML_loHalf;

    record CEcellar_EnEV2009_SML_loHalf
        "Ceiling cellar after EnEV 2009, for building of type S (schwer), M (mittel) and L (leicht), lower half"
        extends WallBaseDataDefinition(
          n(min=1) = 3 "Number of wall layers",
          d={0.02,0.16,0.06} "Thickness of wall layers",
          rho={120,2300,120} "Density of wall layers",
          lambda={0.045,2.3,0.04} "Thermal conductivity of wall layers",
          c={1030,1000,1030} "Specific heat capacity of wall layers",
          eps=0.95 "Emissivity of inner wall surface");
        annotation (Documentation(revisions="<html>
<p><ul>
<li><i>September 5, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
<li><i>Juni 1, 2011</i> by Ana Constantin:<br/>implemented</li>
</ul></p>
</html>",
    info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Wall definition according to EnEV 2009. For detailed wall type see above. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars5.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>port_a</code>(outside), the last element represents the layer connected to <code>port_b</code>(surface facing the room). </p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a></p>
<p>Norm: </p>
<ul>
<li>Bundesregierung (Veranst.): Verordnung &uuml;ber energiesparenden W&auml;rmeschutz und energiesparende Anlagentechnik bei Geb&auml;uden. Berlin, 2009 </li>
</ul>
</html>"));
    end CEcellar_EnEV2009_SML_loHalf;

    record ROsaddleAttic_EnEV2009_SML
        "Saddle roof in attic after EnEV 2009, for building of type S (schwer), M (mittel) and L (leicht)"
        extends WallBaseDataDefinition(
          n(min=1) = 1 "Number of wall layers",
          d={0.22} "Thickness of wall layers",
          rho={194} "Density of wall layers",
          lambda={0.045} "Thermal conductivity of wall layers",
          c={1301} "Specific heat capacity of wall layers",
          eps=0.95 "Emissivity of inner wall surface");
        annotation (Documentation(revisions="<html>
<p><ul>
<li><i>September 5, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
<li><i>Juni 1, 2011</i> by Ana Constantin:<br/>implemented</li>
</ul></p>
</html>",
    info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Wall definition according to EnEV 2009. For detailed wall type see above. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars5.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>port_a</code>(outside), the last element represents the layer connected to <code>port_b</code>(surface facing the room). </p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a></p>
<p>Norm: </p>
<ul>
<li>Bundesregierung (Veranst.): Verordnung &uuml;ber energiesparenden W&auml;rmeschutz und energiesparende Anlagentechnik bei Geb&auml;uden. Berlin, 2009 </li>
</ul>
</html>"));
    end ROsaddleAttic_EnEV2009_SML;

    record ROsaddleRoom_EnEV2009_SML
        "Saddle roof in room after EnEV 2009, for building of type S (schwer), M (mittel) and L (leicht)"
        extends WallBaseDataDefinition(
          n(min=1) = 3 "Number of wall layers",
          d={0.22,0.0125,0.015} "Thickness of wall layers",
          rho={194,800,1200} "Density of wall layers",
          lambda={0.045,0.25,0.51} "Thermal conductivity of wall layers",
          c={1301,1000,1000} "Specific heat capacity of wall layers",
          eps=0.95 "Emissivity of inner wall surface");
        annotation (Documentation(revisions="<html>
<p><ul>
<li><i>September 5, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
<li><i>Juni 1, 2011</i> by Ana Constantin:<br/>implemented</li>
</ul></p>
</html>",
    info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Wall definition according to EnEV 2009. For detailed wall type see above. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars5.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>port_a</code>(outside), the last element represents the layer connected to <code>port_b</code>(surface facing the room). </p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a></p>
<p>Norm: </p>
<ul>
<li>Bundesregierung (Veranst.): Verordnung &uuml;ber energiesparenden W&auml;rmeschutz und energiesparende Anlagentechnik bei Geb&auml;uden. Berlin, 2009 </li>
</ul>
</html>"));
    end ROsaddleRoom_EnEV2009_SML;
    end Ceiling;
  end EnEV2009;
  annotation (Documentation(info="<html>
<p><br/>Selectable wall types for easy setup of room configurations. </p>
</html>"));
end Walls;
