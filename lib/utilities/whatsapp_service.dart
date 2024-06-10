import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WhatsAppService {
  final String accessToken = 'EAAG9wpGRZA0cBO1w5iuGBohkBuOcdfZAmdZAckX2MPWWxa0v09hAabqHbOP9H2VcHFSorpDhIyqAvOupA1WtKZA6wvLlwBZCLUbRtyMGaiZCAjmhxASGJnBMbuzQ2EtWLVJ7xY84iAopMbivIyCJZCfq0upQNT1suSIRgXC3tVLtKMEyebxUOl6DSRhRedLhF019qLfZAuba1DNEjTd3d4EZD';
  final String phoneNumberId = '328124060386085';

  Future<void> sendOtpMessage(String userPhoneNumber, String otp) async {
    final url = 'https://graph.facebook.com/v19.0/328124060386085/messages';

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    final body = json.encode({

      "messaging_product": "whatsapp",
      "to": "+918877542303",
      "type": "template",
      "template": {
        "name": "order_id",
        "language": {
          "code": "en_US"
        },
        "components": [
          {
            "type": "body",
            "parameters": [
              {
                "type": "text",
                "text": "8877"
              }
            ]
          }
        ]
      }
    });

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        print('OTP message sent successfully');
      } else {
        print('Failed to send OTP message: ${response.body}');
      }
    } catch (e) {
      print('Error sending OTP message: $e');
    }
  }
}
