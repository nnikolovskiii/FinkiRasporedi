using FinkiRasporedi.Models.Identity;
using FinkiRasporedi.Repository.Interface;
using Microsoft.AspNetCore.Identity;

namespace FinkiRasporedi.Repository.Impl
{
    public class StudentRepository : IStudentRepository
    {
        private readonly UserManager<Student> _userManager;

        public StudentRepository(UserManager<Student> userManager)
        {
            _userManager = userManager;
        }

        public async Task<Student> RegisterAsync(StudentRegistrationModel registrationModel)
        {
            var student = new Student { UserName = registrationModel.Username, Email = registrationModel.Email };
            var result = await _userManager.CreateAsync(student, registrationModel.Password);
            if (result.Succeeded)
            {
                return student;
            }
            else
            {
                throw new Exception("Failed to register student.");
            }
        }

        public async Task<Student> LoginAsync(string username, string password)
        {
            var user = await _userManager.FindByNameAsync(username);
            if (user != null && await _userManager.CheckPasswordAsync(user, password))
            {
                return user;
            }
            else
            {
                return null;
            }
        }
    }
}
