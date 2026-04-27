export class ProductService {
  constructor(productRepository) {
    this.productRepository = productRepository;
  }

  async listProducts() {
    return this.productRepository.getAll();
  }

  async createProduct(payload) {
    const normalized = this.#validateProductPayload(payload);
    return this.productRepository.create(normalized);
  }

  async updateProduct(id, payload) {
    const normalized = this.#validateProductPayload(payload);
    return this.productRepository.update(id, normalized);
  }

  async updateProductAmount(id, payload) {
    const amount = this.#validateAmount(payload?.amount);
    return this.productRepository.updateAmount(id, amount);
  }

  async deleteProduct(id) {
    return this.productRepository.delete(id);
  }

  #validateProductPayload(payload) {
    const name = this.#validateName(payload?.name);
    const amount = this.#validateAmount(payload?.amount);
    return { name, amount };
  }

  #validateName(name) {
    if (typeof name !== 'string') {
      throw new Error('Name must be a string.');
    }

    const normalizedName = name.trim();
    if (normalizedName.length === 0) {
      throw new Error('Name cannot be empty.');
    }

    if (normalizedName.length > 120) {
      throw new Error('Name must be at most 120 characters long.');
    }

    return normalizedName;
  }

  #validateAmount(amount) {
    if (!Number.isInteger(amount)) {
      throw new Error('Amount must be an integer.');
    }

    if (amount < 0) {
      throw new Error('Amount cannot be negative.');
    }

    return amount;
  }
}
