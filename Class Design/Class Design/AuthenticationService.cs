class AuthenticationService
{
    public bool ValidateUser(string email, string password);
    public bool CheckVerification(string email);
    public void RegisterUser(User user);
}
