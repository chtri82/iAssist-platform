using Microsoft.AspNetCore.Mvc;
using iAssist.ApiGateway.Data;

namespace iAssist.ApiGateway.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class TrainingController : ControllerBase
    {
        private readonly TrainingService _trainingService;

        public TrainingController(TrainingService trainingService)
        {
            _trainingService = trainingService;
        }

        /// <summary>
        /// Triggers a mock training pipeline in the public build.
        /// </summary>
        [HttpPost("start")]
        public IActionResult StartTraining()
        {
            var result = _trainingService.Train();
            return Ok(new { message = result, timestamp = DateTime.UtcNow });
        }

        /// <summary>
        /// Returns mock training status.
        /// </summary>
        [HttpGet("status")]
        public IActionResult GetStatus()
        {
            var status = _trainingService.GetStatus();
            return Ok(new { status, time = DateTime.UtcNow });
        }
    }
}
