within AixLib.Electrical.DC.Interfaces;
connector Terminal_p "Terminal p for DC electrical systems"
  extends AixLib.Electrical.Interfaces.Terminal(
    redeclare package PhaseSystem =
        AixLib.Electrical.PhaseSystems.TwoConductor);
  annotation (Icon(graphics={  Polygon(
          points={{-120,0},{0,-120},{120,0},{0,120},{-120,0}},
          lineColor={0,0,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid)}), Documentation(info="<html>
<p>Electric connector for DC electrical systems.</p>
</html>"),
   __Dymola_LockedEditing="Model from IBPSA");
end Terminal_p;
