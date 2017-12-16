within AixLib.Fluid.HeatExchangers.MovingBoundaryHeatExchangers.SimpleHeatExchangers;
model SimpleEvaporator "Model of a simple moving boundary evaporator"
  extends BaseClasses.PartialSimpleHeatExchanger(
    final appHX=Utilities.Types.ApplicationHX.Evaporator,
    redeclare final model MovBouCel = Utilities.FluidCells.EvaporatorCell,
    redeclare final model GuaMod = Utilities.Guards.GeneralGuard,
    redeclare final model WalMod = Utilities.WallCells.SimpleWallCell,
    redeclare final model SecFluMod = Utilities.FluidCells.SecondaryFluidCell);

equation
  // Connection of main components
  //
  connect(port_a2, movBouCel.port_a)
    annotation (Line(points={{100,-60},{70,-60},{10,-60}},color={0,127,255}));
  connect(port_b2, movBouCel.port_b)
    annotation (Line(points={{-100,-60},{-92,-60},{-10,-60}},color={0,127,255}));

  if typHX==Utilities.Types.TypeHX.CounterCurrent then
    connect(port_a1, secFluCel.port_b);
    connect(port_b1, secFluCel.port_a);
  else
    connect(port_a1, secFluCel.port_a);
    connect(port_b1, secFluCel.port_b);
  end if;

  // Connection of heat flows
  //
  connect(movBouCel.heatPortSC, walCel.heatPortSCPri)
    annotation (Line(points={{2.6,-50},{2.6,-50},{2.6,-10}}, color={191,0,0}));
  connect(movBouCel.heatPortTP, walCel.heatPortTPPri)
    annotation (Line(points={{0,-50},{0,-50},{0,-10}}, color={191,0,0}));
  connect(movBouCel.heatPortSH, walCel.heatPortSHPri)
    annotation (Line(points={{-2.6,-50},{-2.6,-50},{-2.6,-10}}, color={191,0,0}));
  connect(walCel.heatPortSCSec, secFluCel.heatPortSC)
    annotation (Line(points={{2.6,10},{2.6,10},{2.6,50}}, color={191,0,0}));
  connect(walCel.heatPortTPSec, secFluCel.heatPortTP)
    annotation (Line(points={{0,10},{0,30},{0,50}}, color={191,0,0}));
  connect(walCel.heatPortSHSec, secFluCel.heatPortSH)
    annotation (Line(points={{-2.6,10},{-2.6,10},{-2.6,50}}, color={191,0,0}));

  // Connection of lengths and guards
  //
  connect(movBouCel.lenOut, walCel.lenInl)
    annotation (Line(points={{-5,-50},{-5,-50},{-5,-10}}, color={0,0,127}));
  connect(walCel.lenOut, secFluCel.lenInl)
    annotation (Line(points={{-5,10},{-5,10},{-5,50}}, color={0,0,127}));
  connect(gua.modCV, walCel.modCV)
    annotation (Line(points={{-39.8,0},{-20,0},{-20,
          -30},{-7,-30},{-7,-10}}, color={0,0,127}));
  connect(gua.modCV, movBouCel.modCV)
    annotation (Line(points={{-39.8,0},{-20,0},
          {-20,-30},{-7,-30},{-7,-50}}, color={0,0,127}));


  annotation (Icon(graphics={Text(
                extent={{-80,80},{80,-80}},
                lineColor={28,108,200},
                textString="Eva")}),
            Diagram(graphics={Line(points={{-100,60},{-10,60}},
            color={0,127,255}), Line(points={{10,60},{100,60}},
            color={0,127,255})}));
end SimpleEvaporator;
