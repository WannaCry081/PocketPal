import "package:flutter/material.dart";
import "package:pocket_pal/utils/envelope_structure_util.dart";


class EnvelopeContentPage extends StatelessWidget {
  final Envelope envelope;

  const EnvelopeContentPage({ 
    super.key,
    required this.envelope
  });

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(),

      body : Center(
        child : Text(
          envelope.envelopeName
        )
      )

    );
  }
}