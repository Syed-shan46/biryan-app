import 'package:googleapis_auth/auth_io.dart';

class GetServerKey {
  Future<String> getServerKeyToken() async {
    final scopes = [
      'https://www.googleapis.com/auth/firebase.database',
      'https://www.googleapis.com/auth/firebase.messaging',
    ];

    final client = await clientViaServiceAccount(
        ServiceAccountCredentials.fromJson({
          "type": "service_account",
          "project_id": "biriyani-59ef6",
          "private_key_id": "6cdff5fb62836447865693984100ff65f8002929",
          "private_key":
              "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDctgf2nzm4vTun\nNAUs6yzYj/lrt4FpGMP6jr65thbvysWuNRlMX1qZAEw52BU6XrZJ/F7IgyvNwEB0\nN8o/cgQfAn9UJQlaFXyU6qphbqzjFh/3fRrU+Pdactip38ltt5cfgWkWrqOemxP0\nFC8eizzvjfwHQfvGe8J2oxcgLNLiG4Qgn/oGaUTkYa0TfhBRMKD4MvoWfDecXY4I\nvAg9Kl2tT5CGBWfwSYGote7q/isNVOywW/yvpcp8OtcU6og4H1o8saJa10qbmEmH\nEZlREmLY1Ftud4dLh4kJM2gnMkzMqiF8+MLizN/PnQHE1i5uxrj52WBBnIr2FUxI\nUBBVvwfRAgMBAAECggEAQrVB8uhtKckIHqE6bzkldM8PM99i3cD+etxqCPdgN1my\nJdUmsE6hs1zDrTgCMoIt1m7QtwnuU2GoGXhDSKnNVRIMKgKHsRKNdPT4SjqJRpmJ\nT+QgF/6nxE6x7aYV23OB2aPjf1eJXIbCoSL4muK6qCzh38+xqWv+ep0QgEkL9AqM\n75GFYYmC0spZ13+4fTHXlKriUYoVYl/VeSqOiEcv+argj9xPXTe7WoCK89QN3Z4G\nk9dbyJvAicbv2tppt4P3C/Kpw3Jxhu72P2pciS/qnBQ7AD2SMLwjmqpMXaH+OBzJ\nR1dWWsHBuT8hekiKXvH5ggK2UtSlMnOifihdKcLHgQKBgQD/+VyIzgLK1VtUzjUL\nHE8a/PqmAlvDGq62NLJB4JCSxZwvIKvOb2Zq88NmPZ19ZxjnsaKQDacMFYc+ckPI\nylLYx7tIwVTNvFhUds9hEQUon7mZVE7aX0nE/SM/1nwo6+/wnXzrWAulQpD7JxGh\nkwkXv7z7xiIT5X4ADbi7Tyd88wKBgQDcu8FPeY1LyV/tIc0n/IB6uxW0fJmKrako\nkKA3BeJEe9NMyQ+Un9ApFPLggSNysakl2YeYDt+blv4fBcaImx1glESl0wuFpIQ7\nmSR+t9N8PUFV5VFhd9fDwJ0YFWKnDkjazAm58dXz5SBb5Zl6kISnlfjsrp6Meo7B\nc+/lioWJKwKBgAF69LEJ1/RKVZPg+WeOC1sRmXV6UAOJ1PbSyTEeVley8ttG6hdw\nh3wY2sltk8qU3Q0B9vm0SoIEYdrXmFLB8Ma2KPwbuhzSeQRMB5j9GzWH7u/XD/mt\nUWTlPd3xpJgr/SA8GOvXf4G+J858BFsV2ZickEA4fhv1WMwxSB81LvpHAoGAR3Xd\nen5OmSeDj8Cuq3Bao+EngLwJ9VSNfB1+UPHts+AmoyhAjAxFFte6XaZRNJOBwEgx\nVrASAkwazy5OfPFCzH6Tzt+JTmXZjXXh08hthj5KhaVs+FIVH0GfWimqO40rVvJR\nf8pkSsZ1+GpXis94ssyhvvY1TCNtTgHbu4NiAesCgYEAhE7jtglgBrr6+AENftpL\nO5bq1faHIX+jguVtETaADaEA4K7R38vKpKvWp/q5uj5ZQsSPBiujBYgK1bQhtAEM\nk7sMi5t52fXBZxWKw3USOKvwSg6WJiYGdkP1ObKRmurVwiADIFo1Rs7COrgvQ/9S\nLUu5ElEJWPyW5VyYdbmfT5g=\n-----END PRIVATE KEY-----\n",
          "client_email":
              "firebase-adminsdk-mbvf2@biriyani-59ef6.iam.gserviceaccount.com",
          "client_id": "108025955690871245320",
          "auth_uri": "https://accounts.google.com/o/oauth2/auth",
          "token_uri": "https://oauth2.googleapis.com/token",
          "auth_provider_x509_cert_url":
              "https://www.googleapis.com/oauth2/v1/certs",
          "client_x509_cert_url":
              "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-mbvf2%40biriyani-59ef6.iam.gserviceaccount.com",
          "universe_domain": "googleapis.com"
        }),
        scopes);
    final accessServerKey = client.credentials.accessToken.data;
    return accessServerKey;
  }
}
