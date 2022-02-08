enum Environment {
  STAGING,
  PRODUCTION,
}

const Environment activeProfile = Environment.STAGING;

String getBaseUrl() {
  switch (activeProfile) {
    case Environment.STAGING:
      return "";

    case Environment.PRODUCTION:
      return "";
  }
}

