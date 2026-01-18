using System.Data;
using Npgsql;
using Dapper;

namespace iAssist.ApiGateway.Data
{
    public class DatabaseService
    {
        private readonly string _connectionString;

        public DatabaseService(IConfiguration config)
        {
            _connectionString = config.GetConnectionString("Postgres") 
                ?? "Host=postgres;Port=5432;Database=iassist;Username=admin;Password=secret";
        }

        private IDbConnection Connection => new NpgsqlConnection(_connectionString);

        public async Task<IEnumerable<dynamic>> GetUsersAsync()
        {
            using var db = Connection;
            return await db.QueryAsync("SELECT * FROM users;");
        }

        public async Task<int> AddUserAsync(string name)
        {
            using var db = Connection;
            var sql = "INSERT INTO users (name) VALUES (@name);";
            return await db.ExecuteAsync(sql, new { name });
        }
    }
}
