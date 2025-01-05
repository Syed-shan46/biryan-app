import 'package:googleapis_auth/auth_io.dart';

class GetServerKey {
  Future<String> getServerKeyToken() async {
    final scopes = [
      'https://www.googleapis.com/auth/userinfo.email',
      'https://www.googleapis.com/auth/firebase.database',
      'https://www.googleapis.com/auth/firebase.messaging',
    ];

    final client = await clientViaServiceAccount(
        ServiceAccountCredentials.fromJson({
          "type": "service_account",
          "project_id": "biriyani-59ef6",
          "private_key_id": "ca1f3dee8692502e8f4b67ad638e59fefb3d1823",
          "private_key":
              "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCpcr3aZCEkHzDF\nYW9LKoEJbelMyxfvCfAdSLqfdJ9malckeTe+TXQqrkKM196WQ7HPPt39FZqxrb4K\n0LB7QG4dDNmy4ppHlDR5biRNw6Xq3f+mG+PCMJ8TTREXNZOoLCEV15eUcxeS4NOZ\nhwEhHI3gm0qSbLCTcdY9MFgI1NIDffb4lW9TPklVopkMBA7DKAPfpvN/kR8BwWGa\niLh+c0T42l1JZt1C23wxniq4vPT5ifBLQ4UOKkhA6E+R8t+cLv9nMxT1wuQYcJlA\nhtY3CJlTE6wOAEYcdVA99MeZ2XbE4v2E1V2vWwsmpPssQdrVtQVjWeftv0yT8fqL\nNhMIJmhhAgMBAAECggEAAmJIZTVxTADSatAk4gzRQ3gNPyYwkj2B3XybD7XITWc1\nDjDJzyq9Fexiku4ReMGvg3ND9DeA3WucsR+NYGeINmQKfvL45rrGh/fmk8+VyA2Q\nYcvcxwFa0elXYnvk9a8iFkdEpSXUdM2xURSyWC7urfngqUQ/50wjw9O9j6lprLtB\nIf/ejUDqG2rDwlLMyhRzlknW25YM3Uhq8CKKGV0THnyKTkEaMPgK/zqEkb3DZdNV\nBYKPsRLs5S386x4xQTvXoc25aMk0RBABvdbAAA1knws4ljGmJzeSNuta/JcRe75B\nqtF6P660WfRU8NUY0r1n4RbKuN1cVSvtif4dxtVCcQKBgQDhNAAK2V+TCocsrOKX\nOzQk4iiXxlE2mvVawEyV5/orlfXgFRap0y1GLDgoz9fdXiBJLXMSyAExduM3ZKny\nl9hDesCVXuMn21zHYi2c9H4sE/7ctVP5KRrkL522D2MaDUbURCxPSlQPAsfGxOkV\ngmixR/58aB74kh4b3YJ8DyJ00QKBgQDAntnyTGcFAgijhkTXhZJtUuc9qOHYGebh\nVm6gMaYonHd281tfxunf/VS13Bma14kXzMH1VAoa04/XNMGnEEkY1p3JnAOCTCUv\n2B2D+tOV+vS6aEcL9C0KE6dmPVLgrUsfnMP+Ls5G4eZoaXEaYM+Avxm9EryccSO7\n/oS5mEXekQKBgQDSfS749PmOzw1PJXxYi96OBtCYI6Wu2yEupIQwrPU4Hd8FhdB8\nBMTRTO1kv/dskditbQycZlIvMIbpNG5gL6rUT3yHYHwCuda7CTnG9QKlIj9ZfSYy\nwUfANf07uKARLo2gQuQDbF6q9RdS4qNVFmHSKY9kKlGgVbpMozqdx+uVsQKBgCUB\nn9/EO/qjVGOOVUWO3P3x8olPG+y3tTrPrztJrqGYxf7tbD2vapllA1RZL/YmuKkA\n5raqabKTuMvgz9+36kNCYFguiCINXQufGrSTiPkEmOYDSLsMM2b/NacX2wddY9Rz\n+tenyGun1Ot0bo1h0hvrGxfPNLtdpT7l/Dvn/GxxAoGADiEw31TaUeNshx3YBdeb\nu4B5UWm7Oukb1UXEdhqmn2lzrY5Z4TtckNeF7Tp+MLAXGlC/RdIc4ZYaFXE9ZZxp\ng+ExgMj0PHPFzC4scn97EVAB3vrEGcMyr1mk9T7e/o/k9Ola51MuxOnbRR2yyx5k\nPIiKVuIgjlRvtDF4m7I30vc=\n-----END PRIVATE KEY-----\n",
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
