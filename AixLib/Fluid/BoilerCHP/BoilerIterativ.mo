within AixLib.Fluid.BoilerCHP;
model BoilerIterativ
  extends AixLib.Fluid.BoilerCHP.BaseClasses.PartialHeatGenerator(
    redeclare package Medium = Media.Water,                       pressureDrop(
        a=coeffPresLoss), vol(energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial, V=(1.1615*QNom/1000 - 13.388)/1000));


     annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end BoilerIterativ;
