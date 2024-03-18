using FinkiRasporedi.Models.Identity;

namespace FinkiRasporedi.Repository.Interface
{
    public interface IStudentRepository
    {
        Task<Student> RegisterAsync(StudentRegistrationModel registrationModel);
        Task<Student> LoginAsync(string username, string password);
    }
}
