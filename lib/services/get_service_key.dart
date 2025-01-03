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
          "private_key_id": "77f2ec91100acee3bd483bf6df8693d24ef5f0d1",
          "private_key":
              "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQC2C/RR7cUhzmeK\nn+CeuXb48OHadhuvCIXKcxtskEkXQ4YleWJfJuIogHcvV9XClnS7KUdNCL1t4v7H\nx55cDFoKa4TWIgnkLV7ExBmsQYmePQuzxQTFxosHQKaNy4wQzPsxF1JlvNnacGrk\nV8fLBydot5A67czrjATHyB9nqC15qHeQu5FUYakMBkZR+a/rIpAxT5983EVDHOjF\n7vIs6jhfREDEczsUC7X5HQeeDDNZzTP3xHAOFTyqEbnge1vWYmqipHzDaC0jcbTp\nCd3WCyltu8Y7V9ed3k30OAeW3ZpYSiKLUJqW5m/bcmskzOq7mOqjf/OLoER5K5y8\nVIcs0aVvAgMBAAECggEABPYKcHkkWCmB1NtKicjQHzShUwzI8FoxGzVL2AeOll22\nuCq4rZMnsqbdmKKyJp1nDPqxAL5uOyJmgxdDj4qeoY4Qjq1ay6cY4A/gCzu1/mP3\nf6ys1p70hvwSDecwJ/0OE2ZpTnB5F2Tc5OAnh7boMghem9yDKyAjuTYQ9Qg2RQxw\nZ62W2ARB1AUIf+pvLSJ9hXHEsWoVBxhhRbwsOjaY6v60wwO25xM39abepx9w/JY/\nB0/y3X3n+4zKiKDvBhYwf7zkE/HW23vGA+BkSXSoERaFc5DnjOGXBe0aZB9zOhD/\nQmSqhDyWbtATXzUiUDuI5W3RIx4UvIFEeqTdDXHzoQKBgQD2ElkKwsBDjeg30jpG\nEwzf6y8n3ge0n87bdAJVSwrt8qcZq8gsz8di0DdHOM61s9S3z1wfmeyG2Hojxj49\n3EzWXOVViaBgGo0D+L8GHTB4kPex6EVTJKZg7vufKpIpMQBxUPahxUQmjH/V4s+s\nTOvHzg7wYMt6p7n8+tBSiyILBwKBgQC9ZExgf2mEae0/Yl+B/IpFWpUfuobQHF3E\nM53IZsVT8WXcBxzgkoL1SuSPqXSEPN8Gr0p5h0FwhYM4cXbJ1coZlhpXjcmxUw0v\nIBvN/z2pcgnzWC5zlyfixQC79MY7U/oX8dVl6Y5o7bEx4nRIRSFdLVkjJBAmndeJ\n+ztvEaGwWQKBgQCh9XuTwJEJJZqlOwJN4vYDX2k/JT0PHmvpNxbeCrFb4e0n0U/E\nZtGF8SOhBfvPzlgAz0OELSxnqI3jg/SthJUyNhxfy2C6QF92ML+SB55CjK/q8cTH\nL4Uuob0Nith+shjnfHGIEi2D7c+p+EnVzx8U+EQO5LaouUKKBo8c9SRn+wKBgBj5\nWuD2rDFbzn8nN7TqWkle8n8ml5RlyS+QJuRAOREiqe3jujka2M4DvDP9gnHVnQtC\nni18WnK+CFmvDJz85hONqZeWCNyrOPfX4hK976GiehFutWFks0vB8qDWXDWCk14I\n87zmmXLYtR8A35iQFSA2VKS/oqmU8tEtId85kfqxAoGBAMvxznHVXqFnC8DbNbvf\ndXrkxF+aGUEVxyTQvLELhBnT7EYG/kARcyYJbIxwmCQ/sEdeLp0DPaGpL3M4dc2O\nvgVWhYlNyTs9GlGiaYwfRIzBXFzXQBvS0sPqd3YWnbKQyVYxFeO8xfYZCOyJhwPN\nY2eL4+tB9o0TnrLk6yenEoI2\n-----END PRIVATE KEY-----\n",
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
