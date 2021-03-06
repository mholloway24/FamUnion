﻿using FamUnion.Core.Interface;
using FamUnion.Core.Model;
using FamUnion.Core.Utility;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FamUnion.Infrastructure.Repository
{
    public class UserRepository : DbAccess<User>, IUserRepository
    {
        public UserRepository(string connection)
            : base(connection)
        {

        }

        public async Task<bool> ValidateUserIdAsync(string userId)
        {
            return (await GetUserByIdAsync(userId)
                .ConfigureAwait(continueOnCapturedContext: false)) != null;
        }

        public async Task<bool> ValidateEmailAsync(string email)
        {
            return (await GetUserByEmailAsync(email)
                .ConfigureAwait(continueOnCapturedContext: false)) != null;
        }

        public async Task<User> GetUserByIdAsync(string userId)
        {
            return (await ExecuteStoredProc("[dbo].[spGetUserById]", ParameterDictionary.Single("userId", userId))
                .ConfigureAwait(continueOnCapturedContext: false)).FirstOrDefault();
        }

        public async Task<User> GetUserByEmailAsync(string email)
        {
            return (await ExecuteStoredProc("[dbo].[spGetUserByEmail]", ParameterDictionary.Single("email", email))
                .ConfigureAwait(continueOnCapturedContext: false)).FirstOrDefault();
        }

        public async Task<User> SaveUserAsync(User user)
        {
            ParameterDictionary parameters = new ParameterDictionary(new string[] {
                "id", user.Id.GetDbGuidString(),
                "userId", user.UserId,
                "email", user.Email,
                "firstName", user.FirstName,
                "lastName", user.LastName,
                "authType", ((int)user.AuthType).ToString()
            });

            return (await ExecuteStoredProc("[dbo].[spSaveUser]", parameters)
                .ConfigureAwait(continueOnCapturedContext: false)).SingleOrDefault();
        }

        public async Task<IEnumerable<User>> GetReunionOrganizers(Guid reunionId)
        {
            ParameterDictionary parameters = ParameterDictionary.Single("reunionId", reunionId);

            return await ExecuteStoredProc("[dbo].[spGetOrganizersByReunionId]", parameters)
                .ConfigureAwait(continueOnCapturedContext: false);
        }
    }
}
