import '/cards/card1/card1_widget.dart';
import '/cards/card2/card2_widget.dart';
import '/cards/card3/card3_widget.dart';
import '/components/nav_bar_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'ticket_widget.dart' show TicketWidget;
import 'package:flutter/material.dart';

class TicketModel extends FlutterFlowModel<TicketWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for Card1 component.
  late Card1Model card1Model;
  // Model for Card2 component.
  late Card2Model card2Model;
  // Model for Card3 component.
  late Card3Model card3Model;
  // Model for NavBar component.
  late NavBarModel navBarModel;

  @override
  void initState(BuildContext context) {
    card1Model = createModel(context, () => Card1Model());
    card2Model = createModel(context, () => Card2Model());
    card3Model = createModel(context, () => Card3Model());
    navBarModel = createModel(context, () => NavBarModel());
  }

  @override
  void dispose() {
    card1Model.dispose();
    card2Model.dispose();
    card3Model.dispose();
    navBarModel.dispose();
  }
}
