import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { Router } from '@angular/router';
import { AuthService } from '../../services/auth.service';

@Component({
  selector: 'app-login',
  standalone: true,
  imports: [CommonModule, FormsModule],
  template: `
    <div class="login-bg">
      <div class="login-container">
        <div class="login-card">
          <h2>Welcome Back</h2>
          <p class="subtitle">Sign in to your account</p>
          <div *ngIf="error" class="alert alert-danger">
            {{ error }}
          </div>
          <form (ngSubmit)="onSubmit()" #loginForm="ngForm">
            <div class="form-group">
              <label for="email">Email</label>
              <input
                type="email"
                id="email"
                name="email"
                [(ngModel)]="email"
                required
                class="form-control"
                placeholder="Enter your email"
              >
            </div>
            <div class="form-group password-group">
              <label for="password">Password</label>
              <div class="password-wrapper">
                <input
                  [type]="showPassword ? 'text' : 'password'"
                  id="password"
                  name="password"
                  [(ngModel)]="password"
                  required
                  class="form-control"
                  placeholder="Enter your password"
                >
                <button type="button" class="show-password-btn" (click)="showPassword = !showPassword" tabindex="-1">
                  {{ showPassword ? 'Hide' : 'Show' }}
                </button>
              </div>
            </div>
            <div class="form-actions">
              <button type="submit" [disabled]="!loginForm.form.valid || loading">
                {{ loading ? 'Logging in...' : 'Login' }}
              </button>
              <p>Don't have an account? <a routerLink="/register">Register</a></p>
            </div>
          </form>
        </div>
      </div>
    </div>
  `,
  styles: [`
    .login-bg {
      min-height: 100vh;
      background: linear-gradient(135deg, #e0e7ff 0%, #f8fafc 100%);
      display: flex;
      align-items: center;
      justify-content: center;
    }
    .login-container {
      display: flex;
      justify-content: center;
      align-items: center;
      min-height: 100vh;
      width: 100vw;
    }
    .login-card {
      background: white;
      padding: 2.5rem 2rem 2rem 2rem;
      border-radius: 16px;
      box-shadow: 0 6px 24px rgba(0, 0, 0, 0.10);
      width: 100%;
      max-width: 400px;
      display: flex;
      flex-direction: column;
      align-items: center;
    }

    h2 {
      margin: 0 0 0.5rem;
      color: #333;
      text-align: center;
      font-size: 2rem;
      font-weight: 700;
    }
    .subtitle {
      color: #6b7280;
      font-size: 1rem;
      margin-bottom: 1.5rem;
      text-align: center;
    }
    .form-group {
      margin-bottom: 1.25rem;
      width: 100%;
    }
    label {
      display: block;
      margin-bottom: 0.5rem;
      color: #555;
      font-weight: 500;
    }
    .form-control {
      width: 100%;
      padding: 0.75rem;
      border: 1px solid #ddd;
      border-radius: 8px;
      font-size: 1rem;
      transition: border-color 0.2s;
      background: #f9fafb;
    }
    .form-control:focus {
      outline: none;
      border-color: #6366f1;
      box-shadow: 0 0 0 2px rgba(99, 102, 241, 0.15);
    }
    .password-group {
      position: relative;
    }
    .password-wrapper {
      display: flex;
      align-items: center;
      position: relative;
    }
    .show-password-btn {
      background: none;
      border: none;
      color: #6366f1;
      font-size: 0.95rem;
      cursor: pointer;
      margin-left: -3.5rem;
      padding: 0 0.5rem;
      height: 100%;
      outline: none;
      position: absolute;
      right: 0.5rem;
      top: 50%;
      transform: translateY(-50%);
    }
    .form-actions {
      margin-top: 1.5rem;
      text-align: center;
      width: 100%;
    }
    button[type="submit"] {
      width: 100%;
      padding: 0.75rem;
      background: linear-gradient(90deg, #6366f1 0%, #60a5fa 100%);
      color: white;
      border: none;
      border-radius: 8px;
      font-size: 1.1rem;
      font-weight: 600;
      cursor: pointer;
      transition: background 0.2s, box-shadow 0.2s;
      box-shadow: 0 2px 8px rgba(99, 102, 241, 0.10);
    }
    button[type="submit"]:hover:not(:disabled) {
      background: linear-gradient(90deg, #4f46e5 0%, #2563eb 100%);
      box-shadow: 0 4px 16px rgba(99, 102, 241, 0.15);
    }
    button[type="submit"]:disabled {
      background: #c7d2fe;
      cursor: not-allowed;
    }
    .alert {
      padding: 0.75rem 1rem;
      margin-bottom: 1rem;
      border-radius: 8px;
      background-color: #f8d7da;
      border: 1px solid #f5c6cb;
      color: #721c24;
      width: 100%;
      text-align: center;
    }
    p {
      margin: 1rem 0 0;
      color: #666;
      font-size: 0.97rem;
    }
    a {
      color: #6366f1;
      text-decoration: none;
      font-weight: 500;
    }
    a:hover {
      text-decoration: underline;
    }
  `]
})
export class LoginComponent {
  email: string = '';
  password: string = '';
  loading: boolean = false;
  error: string = '';
  showPassword: boolean = false;

  constructor(
    private router: Router,
    private authService: AuthService
  ) {
    // Redirect if already logged in
    if (this.authService.isLoggedIn()) {
      this.router.navigate(['/']);
    }
  }

  onSubmit() {
    if (!this.email || !this.password) {
      this.error = 'Please enter both email and password';
      return;
    }

    this.loading = true;
    this.error = '';

    this.authService.login(this.email, this.password).subscribe({
      next: () => {
        this.router.navigate(['/dashboard']);
      },
      error: (error) => {
        this.error = error.message || 'Invalid email or password';
        this.loading = false;
      }
    });
  }
} 