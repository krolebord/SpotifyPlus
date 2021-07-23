using System;
using SpotifyPlus.Errors;

namespace SpotifyPlus.Exceptions
{
    public class AuthManagerException : Exception
    {
        public AuthManagerException(string message) : base(message) {}
    }
}
