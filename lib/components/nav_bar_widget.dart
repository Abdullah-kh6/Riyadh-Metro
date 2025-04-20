import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'nav_bar_model.dart';
export 'nav_bar_model.dart';

class NavBarWidget extends StatefulWidget {
  const NavBarWidget({
    super.key,
    required this.page,
  });

  final String? page;

  @override
  State<NavBarWidget> createState() => _NavBarWidgetState();
}

class _NavBarWidgetState extends State<NavBarWidget> {
  late NavBarModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NavBarModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const AlignmentDirectional(0.0, 1.0),
      child: Container(
        width: double.infinity,
        height: 80.0,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).primary,
          boxShadow: const [
            BoxShadow(
              blurRadius: 4.0,
              color: Color(0x33000000),
              offset: Offset(
                0.0,
                -2.0,
              ),
              spreadRadius: 0.0,
            )
          ],
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(0.0),
            bottomRight: Radius.circular(0.0),
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          shape: BoxShape.rectangle,
        ),
        child: Align(
          alignment: const AlignmentDirectional(0.0, 1.0),
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 8.0, 8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FlutterFlowIconButton(
                            borderRadius: 8.0,
                            buttonSize: 40.0,
                            fillColor: FlutterFlowTheme.of(context).primary,
                            icon: Icon(
                              FFIcons.kmap,
                              color: widget.page == 'Home'
                                  ? FlutterFlowTheme.of(context).alternate
                                  : FlutterFlowTheme.of(context)
                                      .primaryBackground,
                              size: 30.0,
                            ),
                            onPressed: () async {
                              context.pushNamed('Map');
                            },
                          ),
                          Text(
                            FFLocalizations.of(context).getText(
                              '0ayfbe7l' /* Map */,
                            ),
                            style: FlutterFlowTheme.of(context)
                                .labelLarge
                                .override(
                                  fontFamily: 'Readex Pro',
                                  color: FlutterFlowTheme.of(context)
                                      .primaryBackground,
                                  letterSpacing: 0.0,
                                ),
                          ),
                        ].divide(const SizedBox(height: 4.0)),
                      ),
                      const Opacity(
                        opacity: 0.8,
                        child: SizedBox(
                          height: 50.0,
                          child: VerticalDivider(
                            thickness: 1.0,
                            color: Color(0xFF7641A4),
                          ),
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FlutterFlowIconButton(
                            borderRadius: 8.0,
                            buttonSize: 40.0,
                            fillColor: FlutterFlowTheme.of(context).primary,
                            icon: Icon(
                              FFIcons.kticketPerferatedFill,
                              color: widget.page == 'Ticket'
                                  ? FlutterFlowTheme.of(context).alternate
                                  : FlutterFlowTheme.of(context)
                                      .primaryBackground,
                              size: 30.0,
                            ),
                            onPressed: () async {
                              context.pushNamed('Ticket');
                            },
                          ),
                          Text(
                            FFLocalizations.of(context).getText(
                              '7don1yj3' /* Tickets */,
                            ),
                            style: FlutterFlowTheme.of(context)
                                .labelLarge
                                .override(
                                  fontFamily: 'Readex Pro',
                                  color: FlutterFlowTheme.of(context)
                                      .primaryBackground,
                                  letterSpacing: 0.0,
                                ),
                          ),
                        ].divide(const SizedBox(height: 4.0)),
                      ),
                      const Opacity(
                        opacity: 0.8,
                        child: SizedBox(
                          height: 50.0,
                          child: VerticalDivider(
                            thickness: 1.0,
                            color: Color(0xFF7641A4),
                          ),
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FlutterFlowIconButton(
                            borderRadius: 8.0,
                            buttonSize: 40.0,
                            fillColor: FlutterFlowTheme.of(context).primary,
                            icon: Icon(
                              Icons.merge_type,
                              color: widget.page == 'Lines'
                                  ? FlutterFlowTheme.of(context).alternate
                                  : FlutterFlowTheme.of(context)
                                      .primaryBackground,
                              size: 30.0,
                            ),
                            onPressed: () async {
                              context.pushNamed('Lines');
                            },
                          ),
                          Text(
                            FFLocalizations.of(context).getText(
                              'pi1lc29u' /* Lines */,
                            ),
                            style: FlutterFlowTheme.of(context)
                                .labelLarge
                                .override(
                                  fontFamily: 'Readex Pro',
                                  color: FlutterFlowTheme.of(context)
                                      .primaryBackground,
                                  letterSpacing: 0.0,
                                ),
                          ),
                        ].divide(const SizedBox(height: 4.0)),
                      ),
                      const Opacity(
                        opacity: 0.8,
                        child: SizedBox(
                          height: 50.0,
                          child: VerticalDivider(
                            thickness: 1.0,
                            color: Color(0xFF7641A4),
                          ),
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FlutterFlowIconButton(
                            borderRadius: 8.0,
                            buttonSize: 40.0,
                            fillColor: FlutterFlowTheme.of(context).primary,
                            icon: Icon(
                              FFIcons.kpersonFill,
                              color: widget.page == 'Profile'
                                  ? FlutterFlowTheme.of(context).alternate
                                  : FlutterFlowTheme.of(context)
                                      .primaryBackground,
                              size: 30.0,
                            ),
                            onPressed: () async {
                              context.pushNamed('Profile');
                            },
                          ),
                          Text(
                            FFLocalizations.of(context).getText(
                              'qi80j15c' /* Profile */,
                            ),
                            style: FlutterFlowTheme.of(context)
                                .labelLarge
                                .override(
                                  fontFamily: 'Readex Pro',
                                  color: FlutterFlowTheme.of(context)
                                      .primaryBackground,
                                  letterSpacing: 0.0,
                                ),
                          ),
                        ].divide(const SizedBox(height: 4.0)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
