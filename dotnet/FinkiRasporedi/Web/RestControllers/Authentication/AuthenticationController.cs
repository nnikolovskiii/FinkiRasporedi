using FinkiRasporedi.Models.Identity;
using FinkiRasporedi.Repository.Interface;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Mvc;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;

namespace FinkiRasporedi.Controllers.Rest.Authentication
{
    [ApiController]
    [Route("api/auth")]
    public class AuthenticationController : ControllerBase
    {
        private readonly IStudentRepository _studentRepository;
        private readonly IConfiguration _configuration;

        public AuthenticationController(IStudentRepository studentRepository, IConfiguration configuration)
        {
            _studentRepository = studentRepository;
            _configuration = configuration;
        }

        [HttpPost("register")]
        public async Task<IActionResult> Register(StudentRegistrationModel model)
        {
            try
            {
                var user = await _studentRepository.RegisterAsync(model);
                return Ok(new
                {
                    Username = user.UserName,
                    Password = user.PasswordHash
                });
            }
            catch (Exception ex)
            {
                return BadRequest(new { message = ex.Message });
            }
        }

        [HttpPost("login")]
        public async Task<IActionResult> Login(StudentLoginModel model)
        {
            try
            {
                var user = await _studentRepository.LoginAsync(model.Username, model.Password);
                if (user == null)
                    return Unauthorized(new { message = "Invalid username or password" });

                var tokenString = GenerateJwtToken(user);
                return Ok(
                    new
                    {
                        Token = tokenString,
                        Username = user.UserName
                    });
            }
            catch (Exception ex)
            {
                return BadRequest(new { message = ex.Message });
            }
        }


        [HttpPost("logout")]
        public async Task<IActionResult> Logout()
        {
            try
            {
                await HttpContext.SignOutAsync();
                return Ok();
            }
            catch (Exception ex)
            {
                return BadRequest(new { message = ex.Message });
            }
        }

        private string GenerateJwtToken(Student user)
        {
            var tokenHandler = new JwtSecurityTokenHandler();
            var jwtSettings = _configuration.GetSection("JwtSettings");

            if (jwtSettings != null)
            {
                var secretKey = jwtSettings.GetValue<string>("Secret");

                if (secretKey != null)
                {
                    var key = Encoding.ASCII.GetBytes(secretKey);

                    var tokenDescriptor = new SecurityTokenDescriptor
                    {
                        Subject = new ClaimsIdentity(new Claim[]
                        {
                    new(ClaimTypes.Name, user.Id.ToString())
                        }),
                        Expires = DateTime.UtcNow.AddDays(7),
                        SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(key), SecurityAlgorithms.HmacSha256Signature)
                    };

                    var token = tokenHandler.CreateToken(tokenDescriptor);
                    return tokenHandler.WriteToken(token);
                }
                else
                {
                    throw new Exception("Secret key not found in configuration.");
                }
            }
            else
            {
                throw new Exception("JwtSettings section not found in configuration.");
            }
        }

    }
}