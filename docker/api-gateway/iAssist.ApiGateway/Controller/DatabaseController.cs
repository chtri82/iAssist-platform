using Microsoft.AspNetCore.Mvc;
using iAssist.ApiGateway.Data;

namespace iAssist.ApiGateway.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class DatabaseController : ControllerBase
    {
        private readonly DatabaseService _db;

        public DatabaseController(DatabaseService db)
        {
            _db = db;
        }

        [HttpGet("users")]
        public async Task<IActionResult> GetUsers()
        {
            var users = await _db.GetUsersAsync();
            return Ok(users);
        }

        [HttpPost("users")]
        public async Task<IActionResult> AddUser([FromBody] string name)
        {
            var rows = await _db.AddUserAsync(name);
            return Ok(new { inserted = rows });
        }
    }
}
