enum Environment {
  STAGING,
  PRODUCTION,
}

const Environment activeProfile = Environment.STAGING;

String getBaseUrl() {
  switch (activeProfile) {
    case Environment.STAGING:
      return "http://api.stock.dhrubokisl.xyz";

    case Environment.PRODUCTION:
      return "http://api.stock.dhrubokisl.xyz";
  }
}

String getStripeMerchantIdentifier() {
  switch (activeProfile) {
    case Environment.STAGING:
      return "merchant.flutter.stripe.test";

    case Environment.PRODUCTION:
      return "merchant.flutter.stripe.test";
  }
}

String getStripePublishableKey() {
  switch (activeProfile) {
    case Environment.STAGING:
      return "pk_test_51JjHg7JW6jCpxceKmzGO9n3xck1tOPW2kUyLAwOkubSHPWNTPvyl05S8dfyAhLDuZD2v70wqs42fehoIqt38hAam00GCqFyt2A";

    case Environment.PRODUCTION:
      return "pk_test_51JjHg7JW6jCpxceKmzGO9n3xck1tOPW2kUyLAwOkubSHPWNTPvyl05S8dfyAhLDuZD2v70wqs42fehoIqt38hAam00GCqFyt2A";
  }
}

enum UserType {
  CUSTOMER,
  SERVICE_PROVIDER,
  ADMIN,
}

enum WorkStatus {
  ONLINE,
  OFFLINE,
}

enum AddressType {
  OWN,
  BENEFICIARY,
}

enum UserStatus {
  BANNED,
  EMAIL_VERIFIED,
  PENDING,
  VERIFIED
}

enum LoginMethod {
  GOOGLE,
  FACEBOOK,
  APPLE
}

enum UploadType {
  JOB,
  USER_IMAGE,
  VERIFICATION_DOC,
  ADDITIONAL_TASK
}

enum UserRateType {
  DAY,
  NIGHT,
  GENERAL
}

enum HttpMethod {
  GET,
  POST,
  PUT,
}

enum RatingType {
  SERVICE_PROVIDER,
  SERVICE
}

enum PauseResumeType {
  RESUME,
  PAUSE
}

enum JobStatus {
  REQUESTED,
  ACCEPTED,
  EN_ROUTE,
  REACHED,
  REJECTED,
  CANCELLED,
  RUNNING,
  PAUSED,
  ENDED,
  COMPLETED,
  FINISHED,
}

enum VerificationStatus {
  PENDING,
  ACCEPTED,
}

enum DiscountType {
  FIXED,
  PERCENTAGE,
}
