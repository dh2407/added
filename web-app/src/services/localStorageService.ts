export class LocalStorageService {
    public static QUESTIONS_RESPONSES_KEY = 'questionsResponses';

    // Save data to local storage
    public static write<T>(key: string, data: T): void {
        localStorage.setItem(key, JSON.stringify(data));
    }

    // Read data from local storage
    public static read<T>(key: string): T | null {
        const item = localStorage.getItem(key);
        return item ? JSON.parse(item) as T : null;
    }

    // Add to an object in local storage
    public static updateObject<T>(objectKey: string, newObjectValue: Record<string, T[]>): void {
        const existingData = this.read<Record<string, T[]>>(objectKey) || {};
        // Merge newObject into existingData
        Object.keys(newObjectValue).forEach(k => {
            existingData[k] = newObjectValue[k];
        });
        this.write(objectKey, existingData);
    }

    public static removeKeyValueFromObject<T>(objectKey: string, key: string): void {
        const existingData = this.read<Record<string, T[]>>(objectKey) || {};
        // Delete the specified key from the existing data
        delete existingData[key];
        // Write the updated object back to local storage
        this.write(objectKey, existingData);
    }

    // Remove data from local storage
    public static remove(key: string): void {
        localStorage.removeItem(key);
    }

    // Clear all local storage
    public static clear(): void {
        localStorage.clear();
    }
}
