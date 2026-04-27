export class ProductRepository {
  constructor(database) {
    this.database = database;
  }

  async getAll() {
    return this.database.all(
      'SELECT id, name, amount FROM products ORDER BY name COLLATE NOCASE ASC'
    );
  }

  async create({ name, amount }) {
    const result = await this.database.run(
      'INSERT INTO products (name, amount) VALUES (?, ?)',
      [name, amount]
    );

    return this.findById(result.lastID);
  }

  async findById(id) {
    return this.database.get('SELECT id, name, amount FROM products WHERE id = ?', [id]);
  }

  async update(id, { name, amount }) {
    const result = await this.database.run(
      'UPDATE products SET name = ?, amount = ? WHERE id = ?',
      [name, amount, id]
    );

    if (result.changes === 0) {
      return null;
    }

    return this.findById(id);
  }

  async updateAmount(id, amount) {
    const result = await this.database.run(
      'UPDATE products SET amount = ? WHERE id = ?',
      [amount, id]
    );

    if (result.changes === 0) {
      return null;
    }

    return this.findById(id);
  }

  async delete(id) {
    const result = await this.database.run('DELETE FROM products WHERE id = ?', [id]);
    return result.changes > 0;
  }
}
