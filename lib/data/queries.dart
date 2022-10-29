class EpoultryQueries {
  // Auth
  String register() {
    return """
        mutation RegisterUser(\$data: RegisterUserInput!){
            registerUser(data:\$data){
                 firstName,
                 lastName
            }
        }
      """;
  }

  String login() {
    return """
        mutation RequestLoginOtp(\$phoneNumber: String!){
            requestLoginOtp(phoneNumber:\$phoneNumber)
        }
      """;
  }

  String verifyOtp() {
    return """
    mutation VerifyOtp(\$otpCode: String!,\$phoneNumber: String!){
         verifyOtp(otpCode: \$otpCode,phoneNumber: \$phoneNumber){
              apiKey,
              user{
                  id,
                  farmer{
                    gender
                  },
                  firstName,
                  lastName,
                  phoneNumber,
                  managingFarms{
                    id,
                    name
                    batches{
                        id,
                name,
                birdType,
                birdAge,
                birdCount,
                ageType
                      reports{
                        id,
                        reportDate,
                        eggCollection{
                          id,
                          badCount,
                          badCountClassification{
                            broken,
                            deformed
                          },
                          goodCount,
                          goodCountClassification{
                            large,
                            small
                          },
                       },
                        birdCounts{
                          id,
                          quantity,
                          reason
                       }
                     }
                    }
                  },
                  ownedFarms{
                    id,
                    name,
                      batches{
                          id,
                name,
                birdType,
                birdAge,
                birdCount,
                ageType
                      reports{
                        id,
                        reportDate,
                        eggCollection{
                          id,
                          badCount,
                          badCountClassification{
                            broken,
                            deformed
                          },
                          goodCount,
                          goodCountClassification{
                            large,
                            small
                          },
                       },
                        birdCounts{
                          id,
                          quantity,
                          reason
                       }
                     }
                    }
                  }
             }
         }
    }
     """;
  }

  // Auth
  String getUserDetails() {
    return """
    query {
        user {
            id,
            firstName,
            lastName,
            phoneNumber,
           
        }
    }
    """;
  }

  String dashboardData() {
    return """
   query {
       user{
          managingFarms{
              id
              birdCount,
              eggCount
          },
           ownedFarms{
              id
              birdCount,
              eggCount
            }
	      }
    }
    """;
  }

  String joinFarm() {
    return """
    mutation JoinFarm(\$inviteCode: String!){
         joinFarm(inviteCode: \$inviteCode){
              id,
              name,
         }
    }
     """;
  }

  String dashboardReports() {
    return """
  query {
       user{
          managingFarms{
            batches{
              reports{
                id,
                reportDate,
                eggCollection{
                     id,
                     badCount,
                     badCountClassification{
                          broken,
                          deformed
                      },
                     goodCount,
                     goodCountClassification{
                          large,
                          small
                      },
                },
               birdCounts{
                    id,
                    quantity,
                    reason
                }
              }
            }
          },
          ownedFarms{
            batches{
              reports{
                id,
                reportDate,
                eggCollection{
                     id,
                     badCount,
                     badCountClassification{
                          broken,
                          deformed
                      },
                     goodCount,
                     goodCountClassification{
                          large,
                          small
                      },
                },
                birdCounts{
                    id,
                    quantity,
                    reason
                }
              }
            }
          }
	      }
    }
    """;
  }

  // Batches

  String listBatches() {
    return """
   query {
       user{
          managingFarms{
             batches{
                id,
                name,
                birdType,
                birdAge,
                birdCount,
                ageType
             }
          },
           ownedFarms{
              batches{
                id,
                name,
                birdType,
                birdAge,
                birdCount,
                ageType
             }
            }
	      },
         
    }
    """;
  }

  String createBatch() {
    return """
     mutation CreateBatch(\$data: CreateBatchInput!) {
         createBatch(data: \$data){
                  id,
                  name
         }
    }
    """;
  }

  String updateProfile() {
    return """
     mutation UpdateUser(\$data: UpdateUserInput!) {
         updateUser(data: \$data){
                  id,
                 
         }
    }
    """;
  }

  String requestQuotation() {
    return """
     mutation requestQuotation(\$data:  RequestQuotationInput!) {
         requestQuotation(data: \$data){
                createdAt,
                items{
                  name,
                  quantity
                }
         }
    }
    """;
  }

  String createBatchReport() {
    return """
    mutation CreateBatchReport(\$data: CreateBatchReportInput!){
        createBatchReport(data: \$data){
                    id,
                    reportDate
        }
    }
    """;
  }

  // Batches

  // Farm

  String createFarm() {
    return """
    mutation CreateFarm(\$data: CreateFarmInput!){
         createFarm(data: \$data){
              id,
              name,
         }
    }
     """;
  }

  String removeFarmManager() {
    return """
    mutation RemoveFarmManager(\$farmId: UUID!,\$farmManagerId: UUID!){
         removeFarmManager(farmId: \$farmId,farmManagerId: \$farmManagerId)
    }
     """;
  }

  String createInvite() {
    return """
    mutation CreateInvite(\$farmId: UUID!){
        createInvite(farmId: \$farmId){
            expiry,
            inviteCode
        }
    }
    """;
  }

  String getContractors() {
    return """
   query {
       contractors{
              id,
              name
	      }
    }
    """;
  }

  String getFarms() {
    return """
   query {
       user{
      managingFarms {
        id,
        name
      },
         ownedFarms{
              id,
        name
            }
    }
    }
    """;
  }

  String getFarmManagers() {
    return """
      query {
     farmManagers{
      id,
      firstName,
      lastName,
      managingFarms{
        id,
        name
      }
    }
    }
    """;
  }

  String getFarm() {
    return """
        query GetFarm(\$farmId: UUID!){
          getFarm(farmId: \$farmId){  
              id,
              name,
              birdCount,
              eggCount,
              feedsUsage,
               batches{
                id,
                name,
                birdType,
                birdAge,
                birdCount,
                ageType,
                reports{
                id,
                reportDate,
                eggCollection{
                     id,
                     badCount,
                     badCountClassification{
                          broken,
                          deformed
                      },
                     goodCount,
                     goodCountClassification{
                          large,
                          small
                      },
                },
                birdCounts{
                    id,
                    quantity,
                    reason
                }
              }
             }
          }
        }
    """;
  }
}
