import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:googleapis_auth/auth_io.dart';

class GetServerKey {
  Future<String> getServerKeyToken() async {
    await dotenv.load();

    final String privateKey = dotenv.get('FIREBASE_SECRET_KEY');
    final String projectId = dotenv.get('FIREBASE_PROJECT_ID');
    final String clientId = dotenv.get('FIREBASE_CLIENT_ID');
    final String privateKeyId = dotenv.get('FIREBASE_PRIVATE_KEY_ID');
    final String clientEmail = dotenv.get('FIREBASE_CLIENT_EMAIL');
    final scopes = [
      'https://www.googleapis.com/auth/firebase.database',
      'https://www.googleapis.com/auth/firebase.messaging',
    ];

    final client = await clientViaServiceAccount(
        ServiceAccountCredentials.fromJson(
          {
            "type": "service_account",
            "project_id": projectId,
            "private_key_id": privateKeyId,
            "private_key": privateKey,
            "client_email": clientEmail,
            "client_id": clientId,
            "auth_uri": "https://accounts.google.com/o/oauth2/auth",
            "token_uri": "https://oauth2.googleapis.com/token",
            "auth_provider_x509_cert_url":
                "https://www.googleapis.com/oauth2/v1/certs",
            "client_x509_cert_url":
                "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-mbvf2%40biriyani-59ef6.iam.gserviceaccount.com",
            "universe_domain": "googleapis.com"
          },
        ),
        scopes);
    final accessServerKey = client.credentials.accessToken.data;
    return accessServerKey;
  }
}
