import 'package:googleapis_auth/auth_io.dart';

class GetServerKey {
  Future<String> getServerKeyToken() async {
    final scopes = [
      'https://www.googleapis.com/auth/firebase.database',
      'https://www.googleapis.com/auth/firebase.messaging',
    ];

    final client = await clientViaServiceAccount(
        ServiceAccountCredentials.fromJson(
          {
            "type": "service_account",
            "project_id": "biriyani-59ef6",
            "private_key_id": "6de7c0041db75243eb7f4ce0571abca0096ef10f",
            "private_key":
                "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCLoz5yj75Cb9GB\nic1fvCsuBumaKRWevysNhOqK96GBLeftsBv4N8sYZ5qFcRJ7sB0ewxdf6BdV1cnx\nCiXXdE1VKPCSNnOWQp3azSONFiQEnhVoxREA4xnj/hALfgahrku3i/AwHQzMf1y2\nFbmgzW9/QbY0krnztiAIvaeNNbiYSUfnRK9+WFRcyuOH0M2xLiZBDm1+lXudFnxS\n0aQaU0B0Mw8x9eYxHudf7nNBdrXUEjNvNrZlpEubuDbsNMsR/OVFtSgxnGGZbpKr\niHsxaqJVI69UAGdw34rcpHWZKKdbTIVghVdmcamBhQw3b7hgR/9dkq31wazAjOs9\nzc9f7mIZAgMBAAECggEAKCw2TpIxK/7seMaS6cyCZbMCaOISAMJB2hlXutRESBxT\nYcvtOAuhJ+vChkqCBUilEBETe/mTIRQpDWocefBRQUNOdtoohd2zeVvUMwZgJV3v\njd1IJ4eujquspQnEUaaJzQv69XSeFoU7wHzekzcXMTbP+y8NRWKrs6gQeK0wZssd\nilxpZcTeyl9/qVl1appg28Vyxm0o3uTAHlfW78TRJwXuzwngkWhTqWxiMEVmwDzy\ndgj36uc1f2k5PQKvu4WdQIMLMO3z9BBxFKzhafe7p1cmIjiZeMZtMt+hTeaIxhNT\nnDl0oUizWq0zw4cnVJy4kA2HvR9+UvizGAk6XA7jawKBgQDCX90xllJUMqolqx7R\nxxgkpABG9p+qRRtg1LDh+LtK7Gay177RfpP/l91gdprYdHu9KEsTxDBE7joEnE4B\ndC0tEi4dh/yp2Sufa3RXfIRR0ngZQUp84X7y5tK/WvuXCwYl/ZdqJuR44joPNwI6\nLAe2CXGTKiSqRTu/T2rXbybf2wKBgQC36L4/407wZAvYXGe0Lsqtjxfg1rKt0Scv\n5g1MOKpWaMPwJwSf8+1gXjwpHKt5QbGfFb49L9qghIvobtGhWVyY/ca9DZSnUKXV\nlpwQcSblHe749gEX1+Bp/uslsBoBTwt05IwyXLEE/fnZV/bJEVXhHA1kilQqkD1s\nCPCsVhQyGwKBgAg69Ou/mLbV+lxj9YcebghHJXfbw4D7MiCUgPTgilWu0t5pwjuu\np2egL5CBFSdrLz4gMaWhngWdLLm7QJZRLASHi4pWkr1CY9V5QFDgBd5NEibHm/bT\nuYNhgLT3jkWkAtui9EFbajswIRM52g9Kg/0SQ0ve8fR/v/rmyvhaTYQXAoGAXqcZ\nE8Sn4i17szWL4j6a7czR21RkzfTxmENs4Kfhc2ukPLu4M6LVr12Q1Q/+aQAYrOoB\n6Xfxq9/MKiqvFb3qXItwd+i/c4WcdFt5ozS5cf5/+f6S/XSL+cHLwK/sEnReTyE5\nzsnKCem1Z9lQGJglfSB0/CP9wZJPKoVHaUs8RbUCgYEAmx04EaHLoMf+wgyrYQVH\nPaeRtH7l5DITNPD85ne4z8rGHSXeWkreeOc+zFwBqhi5C7sGYnn+otEX/syO3WpH\n9a1qyojjXRX+5t504Ht3vOVFMR7ezUlbosq4/Au/EJWqBSVEEAfzlz7JmjJBJsUe\n+GhtU+oGUWAEG1ZRXc6l4XU=\n-----END PRIVATE KEY-----\n",
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
          },
        ),
        scopes);
    final accessServerKey = client.credentials.accessToken.data;
    return accessServerKey;
  }
}
