import 'package:flutter/material.dart';

class StartPageWidget extends StatefulWidget {
  const StartPageWidget({super.key});

  @override
  State<StartPageWidget> createState() => _StartPageWidgetState();
}

class _StartPageWidgetState extends State<StartPageWidget> {
  late StartPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => StartPageModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                height: 500,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      FlutterFlowTheme.of(context).primary,
                      FlutterFlowTheme.of(context).secondary
                    ],
                    stops: [0, 1],
                    begin: AlignmentDirectional(0, -1),
                    end: AlignmentDirectional(0, 1),
                  ),
                ),
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0x00FFFFFF), Colors.white],
                      stops: [0, 1],
                      begin: AlignmentDirectional(0, -1),
                      end: AlignmentDirectional(0, 1),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).alternate,
                          borderRadius: BorderRadius.circular(16),
                          shape: BoxShape.rectangle,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.network(
                            'https://logo.lusha.co/d/company_6437019_logo.jpg',
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 44, 0, 0),
                        child: Text(
                          'Welcome!',
                          style: FlutterFlowTheme.of(context)
                              .displaySmall
                              .override(
                            fontFamily: 'Plus Jakarta Sans',
                            color: Color(0xFF101213),
                            fontSize: 36,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(44, 8, 44, 0),
                        child: Text(
                          'Thanks for joining! Access or create your account below, and get started on your journey!',
                          textAlign: TextAlign.center,
                          style:
                          FlutterFlowTheme.of(context).labelMedium.override(
                            fontFamily: 'Plus Jakarta Sans',
                            color: Color(0xFF57636C),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16, 24, 16, 44),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Align(
                      alignment: AlignmentDirectional(0, 0),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 8, 16),
                        child: FFButtonWidget(
                          onPressed: () {
                            print('Button pressed ...');
                          },
                          text: 'Get Started',
                          options: FFButtonOptions(
                            width: 230,
                            height: 52,
                            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                            iconPadding:
                            EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                            color: Colors.white,
                            textStyle:
                            FlutterFlowTheme.of(context).bodyLarge.override(
                              fontFamily: 'Plus Jakarta Sans',
                              color: Color(0xFF101213),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                            elevation: 8,
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).primaryText,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: AlignmentDirectional(0, 0),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(8, 0, 0, 16),
                        child: FFButtonWidget(
                          onPressed: () {
                            print('Button pressed ...');
                          },
                          text: 'My Account',
                          options: FFButtonOptions(
                            width: 230,
                            height: 52,
                            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                            iconPadding:
                            EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                            color: FlutterFlowTheme.of(context).secondary,
                            textStyle:
                            FlutterFlowTheme.of(context).bodyLarge.override(
                              fontFamily: 'Plus Jakarta Sans',
                              fontWeight: FontWeight.w500,
                            ),
                            elevation: 8,
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
