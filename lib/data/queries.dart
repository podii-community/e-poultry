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

  String registerExtensionOfficer() {
    return """
        mutation RegisterExtensionOfficer(\$data: RegisterExtensionOfficerInput!){
            registerExtensionOfficer(data:\$data){
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
                role,
                managingFarms{
                  id,
                  name,
                },
                ownedFarms{
                  id,
                  name
                }
              }
         }
    }
     """;
  }

  // Auth
  String getUserDetails() {
    return """
    query GetUserDetails{
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
                ageType,
                todaysSubmission
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
                       },
                       storeReports{
                        quantity,
                        storeItem{
                          name,
                          quantityReceived,
                          quantityUsed,
                          startingQuantity
                        }
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
                ageType,
                todaysSubmission
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
                       },
                        storeReports{
                        quantity,
                        storeItem{
                          name,
                          quantityReceived,
                          quantityUsed,
                          startingQuantity
                        }
                       }
                     }
                    }
                  }
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
              todaysSubmission,
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
                },
                storeReports{
                        quantity,
                        storeItem{
                          name,
                          quantityReceived,
                          quantityUsed,
                          startingQuantity
                        }
                       }
              }
            }
          },
          ownedFarms{
            todaysSubmission,
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
                },
                 storeReports{
                        quantity,
                        storeItem{
                          name,
                          quantityReceived,
                          quantityUsed,
                          startingQuantity
                        }
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
                    reportDate,
                    batch{
                      farm{
                        id
                      }
                    }
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
   query GetFarmManagers(\$farmId: UUID!) {
     farmManagers(farmId: \$farmId){
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
              storeItems{
                itemType,
                name,
                quantityReceived,
                quantityUsed,
                restocks{
                  quantity,
                  dateRestocked
                },
                startingQuantity
              },
               batches{
                id,
                name,
                birdType,
                birdAge,
                birdCount,
                ageType,
                todaysSubmission
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
                },
              }
             }
          }
        }
    """;
  }

  // Reports

  String getFarmReports() {
    return """
          query GetFarmReports(\$filter: FarmReportsFilterInput!) {
           farmReports(filter: \$filter){
             farmId,
            reportDate
           }
          }    
      """;
  }

  String getFarmReport() {
    return """
    query GetFarmReport(\$farmId: UUID!,\$reportDate: Date! ){
        getFarmReport(farmId: \$farmId, reportDate: \$reportDate){
            farmId,
            reportDate,
            reportTime
            birdCounts{
              birdType,
              currentQuantity,
              reasons{
                quantity,
                reason
              },
            },
            eggCollection{
              brokenCount,
              deformedCount,
              goodCount,
            },
            feedsUsage{
              currentQuantity,
              feedType,
              usedQuantity,
            }
        }
    }
    """;
  }

  String searchAddress() {
    return """
      query SearchAddress(\$query: String!){
          searchAddresses(query: \$query){
              county,
              subcounty,
              ward
          }
      }

  """;
  }

  String counties() {
    return """
      query Counties{
          counties{
              code,
              name,
              subcounties{
                code,
                name
              }
        
          }
      }

  """;
  }

  String subcounties() {
    return """
      query Subcounties(\$code: Int!){
          subcounty(code: \$code){
              code,
              name,
          }
      }
  """;
  }

  String wards() {
    return """
      query Wards(\$code: Int!){
          subcounty(code: \$code){
              code,
              name,
              wards{
                code,
                name
              }
          }
      }
  """;
  }

  String storeItems() {
    return """
    query StoreItems(\$filter: StoreItemsFilterInput!){
      storeItems(filter: \$filter){
        id,
        itemType,
        name
      }
    }
    """;
  }

  String requestMedicalVisit() {
    return """
      mutation RequestMedicalVisit(\$data: RequestMedicalVisitInput!){
        requestMedicalVisit(data: \$data){
          farmId
        }
      }
      """;
  }

  String farmRequests() {
    return """
    query FarmRequests(\$filter: ExtensionServiceFilterInput!){
      extensionServiceRequests(filter: \$filter){
        createdAt
        farmId
        status
        farmVisit{
          visitDate
          visitPurpose
        }
        farm{
          name
          address{
            county
            subcounty
          }
          owner{
            firstName
            lastName
          }
        }
      }
}
""";
  }

  String requestFarmVisit() {
    return """
    mutation RequestFarmVisit(\$data: RequestFarmVisitInput!){
      requestFarmVisit(data: \$data){
        farmId
      }
    }
    """;
  }
}
